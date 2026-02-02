import 'dart:async';

import 'package:design_task_1/models/otp_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/register_now_basic_info.dart';
import 'package:design_task_1/pages/store_registration/timer_provider.dart';
import 'package:design_task_1/providers/register_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class OtpVerification extends ConsumerStatefulWidget {
  final UserModel userInfo;
  const OtpVerification({super.key, required this.userInfo});

  @override
  ConsumerState<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends ConsumerState<OtpVerification> {
  bool isOtpVerified = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(otpTimerProvider);
    final timerNotifier = ref.read(otpTimerProvider.notifier);
    var userInfo = widget.userInfo;
    String otp = '';
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
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
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: 56,
                                height: 56,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffa3a3a3)),
                                  borderRadius: BorderRadius.circular(8),
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
                                  text: timerState.secondsLeft > 0
                                      ? 'Resend OTP in ${timerState.secondsLeft} s'
                                      : 'Didn’t receive code? ',
                                  style: TextStyle(color: Color(0xffa3a3a3)),
                                ),
                                TextSpan(
                                  text: timerState.secondsLeft > 0
                                      ? ''
                                      : 'Resend',
                                  style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.red,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (timerState.secondsLeft == 0) {
                                        userInfo = UserModel(
                                          phoneNumber: userInfo.phoneNumber,
                                          name: userInfo.name,
                                          code: userInfo.code,
                                          type: userInfo.type,
                                        );
                                        final result = await ref.read(
                                          registerProvider(userInfo),
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
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
        child: NextButton(
          buttonText: 'Verify',
          onPressed: () async {
            final isValid = _formKey.currentState!.validate();
            if (!isValid) {
              return;
            }
            final otpInfo = OtpModel(
              phoneNumber: userInfo.phoneNumber,
              otp: otp,
              code: userInfo.code,
              type: userInfo.type,
            );
            final result = await ref.read(otpProvider(otpInfo));

            if (context.mounted) {
              if (result.status) {
                isOtpVerified = true;
                messageTost(result.message, context);
                Future.delayed(const Duration(seconds: 3), () {
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterNowBasicInfo(),
                      ),
                      (route) => false,
                    );
                  }
                });
              } else {
                messageTost(result.message, context);
              }
            }
          },
        ),
      ),
    );
  }
}
