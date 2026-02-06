import 'package:design_task_1/pages/error/check_internet_screen.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/send_otp_screen.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_number.dart';
import 'package:design_task_1/providers/connectivity_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        controller: numberController,
                        label: 'Phone Number',
                        hintText: 'Enter number',
                        onCountryCodeChanged: (code) {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
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
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendOtpScreen(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            NextButton(
              buttonText: 'Submit',
              onPressed: () async {
                final isValid = _formKey.currentState!.validate();

                if (!isValid) {
                  messageTost('Field shouldn\'t be empty', context);
                } else {
                  final isConnected = await ref
                      .read(connectivityServiceProvider)
                      .isConnected();
                  if (!isConnected) {
                    if (context.mounted) {
                      messageTost("No internet connection", context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckInternetScreen(),
                        ),
                      );
                    }
                  } else {}
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
