import 'dart:async';

import 'package:design_task_1/models/otp_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/register_now_basic_info.dart';
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
  static const int _initialTime = 60;
  int _secondsLeft = _initialTime;
  bool isOtpVerified = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = _initialTime;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0 && isOtpVerified == false) {
        timer.cancel();
        if (context.mounted) {
          messageTost('OTP expired', context);
        }
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          Pinput(
                            length: 4,
                            onCompleted: (pin) {
                              otp = pin;
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
                          SizedBox(height: 24),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: _secondsLeft > 0
                                      ? 'Resend OTP in $_secondsLeft s'
                                      : 'Didn’t receive code? ',
                                  style: TextStyle(color: Color(0xffa3a3a3)),
                                ),
                                TextSpan(
                                  text: _secondsLeft > 0 ? '' : 'Resend',
                                  style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.red,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (_secondsLeft == 0) {
                                        userInfo = UserModel(
                                          phoneNumber: userInfo.phoneNumber,
                                          name: userInfo.name,
                                          code: userInfo.code,
                                          type: userInfo.type,
                                        );
                                        final result = await ref.read(
                                          registerProvider(userInfo),
                                        );
                                        _startTimer();

                                        if (context.mounted) {
                                          if (result) {
                                            messageTost(
                                              'OTP sent successfully..',
                                              context,
                                            );
                                          } else {
                                            messageTost(
                                              'Something went wrong',
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
            final otpInfo = OtpModel(
              phoneNumber: userInfo.phoneNumber,
              otp: otp,
              code: userInfo.code,
              type: userInfo.type,
            );
            final result = await ref.read(otpProvider(otpInfo));

            if (context.mounted) {
              if (result) {
                isOtpVerified = true;
                messageTost('OTP verified successfully', context);
                Future.delayed(const Duration(seconds: 3), () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterNowBasicInfo(),
                      ),
                    );
                  }
                });
              } else {
                messageTost('Something went wrong', context);
              }
            }
          },
        ),
      ),
    );
  }
}
