import 'package:design_task_1/pages/onboarding/widgets/details.dart';
import 'package:design_task_1/pages/onboarding/widgets/skip_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [SkipButton()],
              ),
            ),

            Expanded(child: Details()),
          ],
        ),
      ),
    );
  }
}
