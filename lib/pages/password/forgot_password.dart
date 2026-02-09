import 'package:design_task_1/pages/error/check_internet_screen.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_number.dart';
import 'package:design_task_1/providers/connectivity_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
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
          child: SingleChildScrollView(
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forgot \nPassword',
                              style: TextStyle(
                                color: Color(0xff2c2c2c),
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Enter your registered phone number',
                              style: TextStyle(
                                color: Color(0xff737373),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            InputNumber(
                              isFieldRequired: false,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        NextButton(
                          buttonText: 'Verify',
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
                                  messageTost(
                                    "No internet connection",
                                    context,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CheckInternetScreen(),
                                    ),
                                  );
                                }
                              } else {}
                            }
                          },
                        ),
                        SizedBox(height: 88),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
