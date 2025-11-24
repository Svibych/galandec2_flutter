import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/lighting_screen.dart';
import 'screens/equipment_screen.dart';
import 'screens/pendant_screen.dart';
import 'screens/sensors_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =
      await SharedPreferences.getInstance(); // Инициализация SharedPrefs
  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

// Provider для SharedPrefs (глобальный)
final sharedPrefsProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galandec2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0x0C2D2D2D),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home:
          const CustomBottomNav(), // Корневой виджет с навигацией (аналог MainActivity)
    );
  }
}

// BottomNav + IndexedStack (аналог ViewPager2 + BottomNavigationView)
class CustomBottomNav extends ConsumerStatefulWidget {
  const CustomBottomNav({super.key});

  @override
  ConsumerState<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends ConsumerState<CustomBottomNav> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const LightingScreen(),
    const EquipmentScreen(),
    const PendantScreen(),
    const SensorsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // Сохраняет состояние экранов (как ViewPager2)
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'), // ic_home_24dp
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Lighting'), // ic_lighting_24dp
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Equipment'), // ic_technic_24dp
          BottomNavigationBarItem(
              icon: Icon(Icons.invert_colors),
              label:
                  'Pendant'), // Фикс: Icons.invert_colors для ic_pendant_24dp
          BottomNavigationBarItem(
              icon: Icon(Icons.sensors), label: 'Sensors'), // ic_sensors_24dp
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
          // Анимация фона (аналог твоей animateBackgroundChanges)
          _animateBackground(index);
        },
      ),
    );
  }

  void _animateBackground(int index) {
    // Здесь можно добавить анимацию (TweenAnimationBuilder для фона items)
    // Для простоты — пропускаем, но можно доработать с AnimatedContainer
  }
}
