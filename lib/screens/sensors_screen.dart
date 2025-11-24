import 'package:flutter/material.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  State<SensorsScreen> createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  String humidity = '86%'; // Пример из XML
  String pressure = '1013 hPa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[],
        body: ListView(
          children: [
            // Температура/Датчики (из XML)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('t на борту: 25°C',
                      style: TextStyle(color: Colors.white)),
                  Text('Влажность: $humidity',
                      style: const TextStyle(color: Colors.white)),
                  Text('Давление: $pressure',
                      style: const TextStyle(color: Colors.white)),
                  // Кнопка сигнализации
                  ElevatedButton(
                    onPressed: () {}, // Добавь Socket для Lock
                    child: const Text('Сигнализация'),
                  ),
                  // Добавь Vlaga_button и другие из fragment_sensors.xml
                  ElevatedButton(
                    onPressed: () {}, // Socket для Vlaga
                    child: const Text('Влажность',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
