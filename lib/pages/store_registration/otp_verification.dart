import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/register_now_basic_info.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
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

              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Pinput(
                        length: 4,
                        onCompleted: (pin) {},
                        separatorBuilder: (index) => const SizedBox(width: 20),
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
                      // Spacer(),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Didn’t receive code? ',
                              style: TextStyle(color: Color(0xffa3a3a3)),
                            ),
                            TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              NextButton(
                buttonText: 'Verify',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterNowBasicInfo(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
