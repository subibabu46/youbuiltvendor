import 'package:design_task_1/constants/shared_pref_names.dart';
import 'package:design_task_1/helpers/check_connection.dart';
import 'package:design_task_1/models/login_model.dart';
import 'package:design_task_1/pages/navigation_menu.dart';
import 'package:design_task_1/pages/login/forgot_password_screen.dart';
import 'package:design_task_1/providers/shared_pref_provider.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:design_task_1/utils/colors_utils.dart';
import 'package:design_task_1/utils/input_text.dart';
import 'package:design_task_1/utils/next_button.dart';
import 'package:design_task_1/pages/registration/send_otp_screen.dart';
import 'package:design_task_1/utils/input_number.dart';
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
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? numberCode;
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  bool _isKeyboardOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    if (_isKeyboardOpen != keyboardOpen) {
      _isKeyboardOpen = keyboardOpen;

      if (!_isKeyboardOpen) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: isKeyboardOpen
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
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
                              'Welcome \nBack!',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Login to your Youbuilt account',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            InputNumber(
                              isFieldRequired: false,
                              controller: phoneNumberController,
                              label: 'Phone Number',
                              hintText: 'Enter number',
                              onCountryCodeChanged: (code) => numberCode = code,
                            ),
                            InputText(
                              isPasswordMode: true,
                              isFieldRequired: false,
                              controller: passwordController,
                              label: 'Password',
                              hintText: 'Enter password',
                            ),
                            Align(
                              alignment: AlignmentGeometry.centerRight,
                              child: GestureDetector(
                                child: Text(
                                  'Forgot password? ',
                                  style: TextStyle(color: AppColors.buttonInfo),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                              ),
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
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'Didn’t registered yet? ',
                                style: TextStyle(color: AppColors.textHint),
                              ),
                              TextSpan(
                                text: 'Register Now',
                                style: TextStyle(
                                  color: AppColors.buttonAction,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.buttonAction,
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
                          onPressed: _submitCall,
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

  Future<void> _submitCall() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      messageTost('Field shouldn\'t be empty', context);
    } else {
      if (!await checkConnection(context, ref)) return;
      final loginInfo = LoginModel(
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
      );
      try {
        final result = await ref.read(loginProvider(loginInfo));
        final pref = ref.watch(sharedPreferencesProvider).value;
        pref?.setInt(SharedPrefNames.stepId, result.id ?? 0);
        pref?.setString(SharedPrefNames.accessToken, result.data);
        if (mounted) {
          if (result.status) {
            messageTost('Login Successfully', context);
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationMenu()),
                    (route) => false,
                  );
                }
              }
            });
          } else {
            messageTost(result.message, context);
          }
        }
      } catch (e) {
        if (mounted) {
          messageTost(duration: 2, e.toString(), context);
        }
      }
    }
  }
}
