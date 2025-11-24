import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({super.key});

  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {
  static const String raspberryIP = '192.168.4.3';
  static const int raspberryPort = 5000;
  Timer? holdTimer;
  DateTime? lastTapTime;

  Future<void> _handleButtonPress(String relay1, String relay2,
      {bool isDoubleClick = false}) async {
    try {
      final socket = await Socket.connect(raspberryIP, raspberryPort);
      if (isDoubleClick) {
        // Двойной клик: выключить оба
        socket.write('toggleRelay_1_off');
        socket.write('toggleRelay_2_off');
      } else {
        // Одинарный: включить relay1, выключить relay2
        socket.write('toggleRelay_1_on');
        socket.write('toggleRelay_2_off');
      }
      await socket.flush();
      await socket.close();
      // Сохрани в SharedPrefs
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('bedRelayState', isDoubleClick ? 0 : 1);
      debugPrint('Sent: ${isDoubleClick ? "Double click" : "Single click"}');
    } catch (e) {
      debugPrint('Socket error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Column(
        children: [
          // Температура (из XML)
          const Padding(
            padding: EdgeInsets.all(16),
            child:
                Text('t на борту: 25°C', style: TextStyle(color: Colors.white)),
          ),
          // Кнопка трансформации (с удержанием/двойным кликом)
          GestureDetector(
            onTapDown: (_) {
              holdTimer = Timer(const Duration(seconds: 1), () {
                // Удержание: пауза
                debugPrint('Hold: Pause');
              });
            },
            onTapUp: (details) {
              holdTimer?.cancel();
              final now = DateTime.now();
              if (lastTapTime != null &&
                  now.difference(lastTapTime!).inMilliseconds < 300) {
                _handleButtonPress('toggleRelay_1', 'toggleRelay_2',
                    isDoubleClick: true);
              } else {
                _handleButtonPress('toggleRelay_1', 'toggleRelay_2');
              }
              lastTapTime = now;
            },
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: const Center(
                  child: Text('Трансформация спальной зоны',
                      style: TextStyle(color: Colors.white))),
            ),
          ),
          // Добавь остальные кнопки из fragment_equipment.xml (Compressor, Bed и т.д.)
          ElevatedButton(
            onPressed: () {}, // Socket для Compressor
            child:
                const Text('Компрессор', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
