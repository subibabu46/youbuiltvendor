import 'dart:developer';

import 'package:design_task_1/constants/shared_pref_names.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/pages/home/home_screen.dart';
import 'package:design_task_1/pages/onboarding/onboarding_screen.dart';
import 'package:design_task_1/pages/registration/register_step_1_screen.dart';
import 'package:design_task_1/pages/registration/register_step_2_screen.dart';
import 'package:design_task_1/pages/registration/register_step_3_screen.dart';
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
          final registerId = pref.getInt(SharedPrefNames.stepId);
          final registerLevel = pref.getInt(SharedPrefNames.level);
          final accessTokenId = pref.getString(SharedPrefNames.accessToken);
          final isOtpVerified = pref.getBool(SharedPrefNames.otpVerified);
          final isUserInfo = pref.getStringList(SharedPrefNames.userInfoCache);
          SharedPrefCatch.instance.addInt(
            name: SharedPrefNames.stepId,
            value: registerId,
          );
          SharedPrefCatch.instance.addInt(
            name: SharedPrefNames.level,
            value: registerLevel,
          );
          SharedPrefCatch.instance.addString(
            name: SharedPrefNames.accessToken,
            value: accessTokenId,
          );
          SharedPrefCatch.instance.addBool(
            name: SharedPrefNames.otpVerified,
            value: isOtpVerified,
          );
          SharedPrefCatch.instance.addStringList(
            name: SharedPrefNames.userInfoCache,
            value: isUserInfo,
          );
          log(
            'register Id: $registerId, completed level: $registerLevel, accessToken: $accessTokenId',
          );
          if (isOtpVerified != null && isOtpVerified) {
            if (registerId != null) {
              if (registerLevel == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterStep2Screen(),
                  ),
                );
              } else if (registerLevel == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterStep3Screen(),
                  ),
                );
              } else if (registerLevel == 3 && accessTokenId != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              }
            } else if (isUserInfo != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => RegisterStep1Screen(
                    userInfo: UserModel(
                      code: isUserInfo[0],
                      name: isUserInfo[1],
                      phoneNumber: isUserInfo[2],
                      type: isUserInfo[3],
                    ),
                  ),
                ),
              );
            }
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
