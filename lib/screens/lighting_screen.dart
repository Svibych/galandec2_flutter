import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart'; // Импорт sharedPrefsProvider

class LightingScreen extends ConsumerStatefulWidget {
  const LightingScreen({super.key});

  @override
  ConsumerState<LightingScreen> createState() => _LightingScreenState();
}

class _LightingScreenState extends ConsumerState<LightingScreen> {
  final Map<String, bool> relayStates = {}; // Состояния реле
  static const String raspberryIP = '192.168.4.3';
  static const int raspberryPort = 5000;

  @override
  void initState() {
    super.initState();
    _loadStates();
  }

  Future<void> _loadStates() async {
    final prefs = ref.read(sharedPrefsProvider);
    setState(() {
      relayStates['left_light'] = prefs.getBool('left_light') ?? false;
      relayStates['right_light'] = prefs.getBool('right_light') ?? false;
      // Добавь все из fragment_lighting.xml (searchlight, marquise и т.д.)
    });
  }

  Future<void> _saveState(String key, bool value) async {
    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setBool(key, value);
    setState(() => relayStates[key] = value);
  }

  Future<void> _sendSocketCommand(String command) async {
    try {
      final socket = await Socket.connect(raspberryIP, raspberryPort);
      socket.write(command);
      await socket.flush();
      await socket.close();
      debugPrint('Sent: $command');
    } catch (e) {
      debugPrint('Socket error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[],
        body: ListView(
          children: [
            // Заголовок + температура
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Освещение',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  const Text('t на борту: 25°C',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            // ToggleButtons (из XML)
            SwitchListTile(
              title: const Text('Улица Левая',
                  style: TextStyle(color: Colors.white)),
              value: relayStates['left_light'] ?? false,
              onChanged: (value) async {
                await _saveState('left_light', value);
                await _sendSocketCommand(
                    value ? 'toggle_Улица_Л_on' : 'toggle_Улица_Л_off');
              },
              activeColor: Colors.blue,
            ),
            SwitchListTile(
              title: const Text('Улица Правая',
                  style: TextStyle(color: Colors.white)),
              value: relayStates['right_light'] ?? false,
              onChanged: (value) async {
                await _saveState('right_light', value);
                await _sendSocketCommand(
                    value ? 'toggle_Улица_П_on' : 'toggle_Улица_П_off');
              },
              activeColor: Colors.blue,
            ),
            // Добавь остальные кнопки: searchlight, marquise, atmospheric_button, working_area, upper_illumimation
            // Пример:
            SwitchListTile(
              title: const Text('Балка', style: TextStyle(color: Colors.white)),
              value: relayStates['searchlight'] ?? false,
              onChanged: (value) async {
                await _saveState('searchlight', value);
                await _sendSocketCommand(
                    value ? 'toggle_Улица_Балка_on' : 'toggle_Улица_Балка_off');
              },
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
