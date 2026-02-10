import 'package:design_task_1/pages/error/check_internet_screen.dart';
import 'package:design_task_1/utils/next_button.dart';
import 'package:design_task_1/utils/input_text.dart';
import 'package:design_task_1/providers/connectivity_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
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
                              'Change \nPassword',
                              style: TextStyle(
                                color: Color(0xff2c2c2c),
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Enter a strong and password for your account',
                              style: TextStyle(
                                color: Color(0xff737373),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            InputText(
                              isPasswordMode: true,
                              isFieldRequired: false,
                              controller: passwordController,
                              label: 'New Password',
                              hintText: 'Enter new password',
                            ),
                            InputText(
                              isPasswordMode: true,
                              isFieldRequired: false,
                              controller: passwordController,
                              label: 'Confirm Password',
                              hintText: 'Renter new password',
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
