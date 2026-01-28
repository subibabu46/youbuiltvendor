import 'package:design_task_1/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youbuilt Vendor',
      theme: ThemeData(
        fontFamily: 'Urbanist',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodySmall: TextStyle(fontFamily: 'Urbanist'),
          bodyMedium: TextStyle(fontFamily: 'Urbanist'),
          bodyLarge: TextStyle(fontFamily: 'Urbanist'),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
