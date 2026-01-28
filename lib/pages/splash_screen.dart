import 'package:design_task_1/pages/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          Image.asset('assets/Final_web 2.png', width: 220, height: 220),
          Text(
            'Construction As A Service',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/Group 1000004398.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
