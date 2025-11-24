import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            /// ------------------- КНОПКА МЕНЮ -------------------
            Positioned(
              top: 0,
              right: 4,
              child: IconButton(
                icon: Image.asset("assets/three_dots.png"),
                iconSize: 48,
                onPressed: () {},
              ),
            ),

            /// ------------------- ЛОГО -------------------
            Positioned(
              top: -8,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  "assets/galandec.png",
                  width: 291,
                  height: 61,
                ),
              ),
            ),

            /// ------------------- БЛОК SENSORS -------------------
            Positioned(
              top: 70,
              left: 12,
              right: 12,
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Stack(
                        children: [
                          // --- t на борту ---
                          Positioned(
                            left: 16,
                            bottom: 0,
                            child: Text(
                              "t на борту",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // value
                          Positioned(
                            left: 16,
                            bottom: 35,
                            child: SizedBox(
                              width: 60,
                              child: Text(
                                "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // --- t за бортом ---
                          Positioned(
                            left: 130,
                            bottom: 0,
                            child: Text(
                              "t за бортом",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 130,
                            bottom: 35,
                            child: SizedBox(
                              width: 60,
                              child: Text(
                                "10",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // --- напряжение ---
                          Positioned(
                            left: 260,
                            bottom: 0,
                            child: Text(
                              "напряжение",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 260,
                            bottom: 35,
                            child: SizedBox(
                              width: 60,
                              child: Text(
                                "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // --- газ ---
                          Positioned(
                            right: 16,
                            bottom: 0,
                            child: Text(
                              "газ",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 35,
                            child: SizedBox(
                              width: 20,
                              child: Text(
                                "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// ------------------- ALARM BUTTON -------------------
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: _glassButton(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            top: 10,
                            child: Image.asset("assets/alarm_system.png",
                                width: 40),
                          ),
                          const Positioned(
                            left: 10,
                            top: 90,
                            child: Text(
                              "Сигнализация",
                              style: TextStyle(
                                fontSize: 21,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 10,
                            top: 130,
                            child: Text(
                              "КЕМПЕР ПОСТАВЛЕН НА ОХРАНУ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                letterSpacing: 0.02,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// ---------------- ТЕХНИКА + ПНЕВМА ------------------
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: _glassButton(
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 12,
                                  top: 11,
                                  child: Image.asset("assets/technic.png",
                                      width: 40),
                                ),
                                const Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: Text(
                                    "Техника",
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: _glassButton(
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 12,
                                  top: 11,
                                  child: Image.asset(
                                    "assets/ic_pendant_24dp.png",
                                    width: 30,
                                  ),
                                ),
                                const Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: Text(
                                    "Пневма",
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// ------------------- LIGHTING -------------------
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: _glassButton(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 9,
                            top: 7,
                            child: Transform.rotate(
                              angle: 3.14,
                              child: Image.asset("assets/lihgt.png", width: 39),
                            ),
                          ),
                          const Positioned(
                            left: 10,
                            top: 90,
                            child: Text(
                              "Свет",
                              style: TextStyle(
                                fontSize: 21,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 10,
                            top: 124,
                            child: Text(
                              "Салон",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                letterSpacing: 0.02,
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 90,
                            top: 124,
                            child: Text(
                              "Улица",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                letterSpacing: 0.02,
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 160,
                            top: 124,
                            child: Text(
                              "Кухня",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                letterSpacing: 0.02,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 20,
                            child: Image.asset(
                              "assets/lighting_on.png",
                              width: 175,
                              height: 148,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Универсальная стеклянная кнопка
  Widget _glassButton({required Widget child}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
