import 'package:flutter/material.dart';
import 'package:intership_app/screens/main_screen.dart';

main() {
  runApp(const ParamApp());
}

class ParamApp extends StatelessWidget {
  const ParamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      theme: ThemeData.from(
        colorScheme: const ColorScheme.dark(),
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            bodyMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
            bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            )),
      ),
    );
  }
}
