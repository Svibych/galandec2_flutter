import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PendantScreen extends StatefulWidget {
  const PendantScreen({super.key});

  @override
  State<PendantScreen> createState() => _PendantScreenState();
}

class _PendantScreenState extends State<PendantScreen> {
  static const String serverIP = '192.168.4.1';
  static const int serverPort = 5000;

  Future<void> _sendPneumaCommand(String command) async {
    try {
      final socket = await Socket.connect(serverIP, serverPort);
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
      body: SingleChildScrollView(
        // Аналог ScrollView
        child: Column(
          children: [
            // GIF (аналог Glide.asGif)
            Image.asset(
              'assets/gifs/galandec.gif',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, color: Colors.white),
            ),
            // Кнопки пневматики (из XML)
            ElevatedButton(
              onPressed: () => _sendPneumaCommand('Пневма_Л_вверх'),
              child: const Text('Пневма Лево Вверх'),
            ),
            ElevatedButton(
              onPressed: () => _sendPneumaCommand('Пневма_Л_вниз'),
              child: const Text('Пневма Лево Вниз'),
            ),
            ElevatedButton(
              onPressed: () => _sendPneumaCommand('Пневма_П_вверх'),
              child: const Text('Пневма Право Вверх'),
            ),
            ElevatedButton(
              onPressed: () => _sendPneumaCommand('Пневма_П_вниз'),
              child: const Text('Пневма Право Вниз'),
            ),
            ElevatedButton(
              onPressed: () => _sendPneumaCommand('Встряхивание'),
              child: const Text('Встряхивание'),
            ),
          ],
        ),
      ),
    );
  }
}
