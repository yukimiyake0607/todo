import 'package:flutter/material.dart';
import 'package:todo/presentation/pages/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: const Color(0xFFF97316),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFF97316),
          secondary: Color(0xFFEA580C),
          surface: Colors.white,
        ),
      ),
    );
  }
}
