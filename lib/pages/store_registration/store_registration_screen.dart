import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/widgets/input_number.dart';
import 'package:design_task_1/pages/registration/widgets/input_text.dart';
import 'package:design_task_1/pages/store_registration/otp_verification.dart';
import 'package:design_task_1/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreRegistrationScreen extends ConsumerWidget {
  const StoreRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    TextEditingController numberController = TextEditingController();
    String selectedCountryCode = '+91';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let’s \nGet Started',
                style: TextStyle(
                  color: Color(0xff2c2c2c),
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tell Us About Yourself',
                style: TextStyle(
                  color: Color(0xff737373),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              InputText(
                controller: controller,
                label: 'Full Name',
                hintText: 'Enter full name',
              ),
              InputNumber(
                controller: numberController,
                label: 'Phone Number',
                hintText: 'Enter number',
                onCountryCodeChanged: (code) {
                  selectedCountryCode = code;
                },
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
                          text: 'Already have an account? ',
                          style: TextStyle(color: Color(0xffa3a3a3)),
                        ),
                        TextSpan(
                          text: 'Login',
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
                  NextButton(
                    buttonText: 'Submit',
                    onPressed: () async {
                      final userInfo = UserModel(
                        phoneNumber: numberController.text,
                        name: controller.text,
                        code: selectedCountryCode,
                        type: "store",
                      );
                      final result = await ref.read(registerProvider(userInfo));
                      if (context.mounted) {
                        result
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpVerification(),
                                ),
                              )
                            : '';
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
