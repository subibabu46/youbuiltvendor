import 'dart:async';

import 'package:design_task_1/constants/shared_pref_names.dart';
import 'package:design_task_1/helpers/check_connection.dart';
import 'package:design_task_1/models/otp_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/register_step_1_screen.dart';
import 'package:design_task_1/pages/store_registration/provider/timer_provider.dart';
import 'package:design_task_1/providers/shared_pref_provider.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final UserModel userInfo;
  const VerifyOtpScreen({super.key, required this.userInfo});

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  bool isOtpVerified = false;
  final _formKey = GlobalKey<FormState>();
  String otp = '';
  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(otpTimerProvider);
    final timerNotifier = ref.read(otpTimerProvider.notifier);
    var userInfo = widget.userInfo;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OTP \nVerification',
                                style: TextStyle(
                                  color: Color(0xff2c2c2c),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Enter OTP sent to your registered mobile number',
                                style: TextStyle(
                                  color: Color(0xff737373),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 24),

                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Pinput(
                                        length: 4,
                                        onCompleted: (pin) {
                                          otp = pin;
                                        },

                                        errorTextStyle: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter Your Pin';
                                          }

                                          return null;
                                        },
                                        separatorBuilder: (index) =>
                                            const SizedBox(width: 20),
                                        defaultPinTheme: PinTheme(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          width: 56,
                                          height: 56,
                                          textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xffa3a3a3),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        errorPinTheme: PinTheme(
                                          width: 56,
                                          height: 56,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.red,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24),
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                timerState.secondsLeft > 0 &&
                                                    timerState.secondsLeft != 60
                                                ? 'Request OTP in ${timerState.secondsLeft} s'
                                                : 'Didn’t receive code? ',
                                            style: TextStyle(
                                              color: Color(0xffa3a3a3),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                timerState.secondsLeft > 0 &&
                                                    timerState.secondsLeft != 60
                                                ? ''
                                                : 'Resend',
                                            style: TextStyle(
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.red,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                if (timerState.secondsLeft ==
                                                    0) {
                                                  userInfo = UserModel(
                                                    phoneNumber:
                                                        userInfo.phoneNumber,
                                                    name: userInfo.name,
                                                    code: userInfo.code,
                                                    type: userInfo.type,
                                                  );
                                                  final result = await ref.read(
                                                    sendOtpProvider(userInfo),
                                                  );
                                                  timerNotifier.start();

                                                  if (context.mounted) {
                                                    if (result.status) {
                                                      messageTost(
                                                        result.message,
                                                        context,
                                                      );
                                                    } else {
                                                      messageTost(
                                                        result.message,
                                                        context,
                                                      );
                                                    }
                                                  }
                                                }
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 64,
                          left: 16,
                          right: 16,
                        ),
                        child: NextButton(
                          buttonText: 'Verify',
                          onPressed: () async {
                            final isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            }
                            if (!await checkConnection(context, ref)) return;
                            final otpInfo = OtpModel(
                              phoneNumber: userInfo.phoneNumber,
                              otp: otp,
                              code: userInfo.code,
                              type: userInfo.type,
                            );
                            try {
                              final result = await ref.read(
                                verifyOtpProvider(otpInfo),
                              );
                              final pref = ref
                                  .watch(sharedPreferencesProvider)
                                  .value;
                              pref?.setBool(otpVerified, result.status);
                              if (context.mounted) {
                                if (result.status) {
                                  isOtpVerified = true;
                                  pref?.setStringList(userInfoCache, [
                                    userInfo.code,
                                    userInfo.name,
                                    userInfo.phoneNumber,
                                    userInfo.type,
                                  ]);

                                  messageTost(result.message, context);
                                  Future.delayed(
                                    const Duration(seconds: 3),
                                    () {
                                      if (context.mounted) {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterStep1Screen(
                                                  userInfo: userInfo,
                                                ),
                                          ),
                                          (route) => false,
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  messageTost(result.message, context);
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                messageTost(duration: 2, e.toString(), context);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
