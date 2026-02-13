import 'package:design_task_1/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Youbuilt Vendor',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarThemeData(backgroundColor: Colors.white),
          fontFamily: 'Urbanist',
          textTheme: ThemeData.light().textTheme.copyWith(
            bodySmall: TextStyle(fontFamily: 'Urbanist'),
            bodyMedium: TextStyle(fontFamily: 'Urbanist'),
            bodyLarge: TextStyle(fontFamily: 'Urbanist'),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
