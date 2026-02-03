import 'dart:developer';

import 'package:design_task_1/constants/shared_pref_names.dart';
import 'package:design_task_1/pages/onboarding/onboarding_screen.dart';
import 'package:design_task_1/pages/store_registration/register_step_2_screen.dart';
import 'package:design_task_1/providers/shared_pref_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefAsync = ref.watch(sharedPreferencesProvider);

    prefAsync.whenData((pref) {
      Future.delayed(const Duration(seconds: 3), () {
        if (!context.mounted) return;

        try {
          final registerId = pref.getInt(step1Id);
          SharedPrefCatch.instance.addInt(name: step1Id, value: registerId);
          log('register step 1 Id: $registerId');
          if (registerId != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const RegisterStep2Screen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const OnboardingScreen()),
            );
          }
        } catch (e) {
          if (context.mounted) {
            messageTost(duration: 2, e.toString(), context);
          }
        }
      });
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          Image.asset('assets/Final_web 2.png', width: 220, height: 220),
          Text(
            'VENDOR',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
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
