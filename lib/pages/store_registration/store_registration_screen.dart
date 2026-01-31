import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/widgets/input_number.dart';
import 'package:design_task_1/pages/registration/widgets/input_text.dart';
import 'package:design_task_1/pages/store_registration/otp_verification.dart';
import 'package:design_task_1/providers/register_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreRegistrationScreen extends ConsumerStatefulWidget {
  const StoreRegistrationScreen({super.key});

  @override
  ConsumerState<StoreRegistrationScreen> createState() =>
      _StoreRegistrationScreenState();
}

class _StoreRegistrationScreenState
    extends ConsumerState<StoreRegistrationScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController numberController = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedCountryCode = '+91';

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
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
                if (numberController.text.isEmpty || controller.text.isEmpty) {
                  messageTost('Fields shouldn\'t be empty', context);
                } else {
                  final userInfo = UserModel(
                    phoneNumber: numberController.text,
                    name: controller.text,
                    code: selectedCountryCode,
                    type: "store",
                  );
                  final result = await ref.read(registerProvider(userInfo));

                  if (context.mounted) {
                    if (result) {
                      messageTost('OTP sent successfully..', context);
                      Future.delayed(const Duration(seconds: 2), () {
                        if (context.mounted) {
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OtpVerification(userInfo: userInfo),
                              ),
                            );
                          }
                        }
                      });
                    } else {
                      messageTost('Something went wrong', context);
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
