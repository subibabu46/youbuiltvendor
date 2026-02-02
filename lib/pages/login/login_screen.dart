import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_number.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                'Welcome \nBack!',
                style: TextStyle(
                  color: Color(0xff2c2c2c),
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Login to your Youbuilt account',
                style: TextStyle(
                  color: Color(0xff737373),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),

              InputNumber(
                controller: controller,
                label: 'Phone Number',
                hintText: 'Enter number',
              ),

              SizedBox(height: 80),
              Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Didn’t registered yet? ',
                          style: TextStyle(color: Color(0xffa3a3a3)),
                        ),
                        TextSpan(
                          text: 'Register Now',
                          style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  NextButton(buttonText: 'Submit', onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
