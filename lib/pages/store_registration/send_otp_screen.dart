import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/pages/error/check_internet_screen.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_number.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_text.dart';
import 'package:design_task_1/pages/store_registration/verify_otp_screen.dart';
import 'package:design_task_1/pages/store_registration/provider/timer_provider.dart';
import 'package:design_task_1/providers/connectivity_provider.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendOtpScreen extends ConsumerStatefulWidget {
  const SendOtpScreen({super.key});

  @override
  ConsumerState<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends ConsumerState<SendOtpScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedCountryCode = '+91';
    final timerState = ref.watch(otpTimerProvider);
    final timerNotifier = ref.read(otpTimerProvider.notifier);

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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (timerState.secondsLeft > 0 && timerState.secondsLeft < 60)
              Text(
                timerState.secondsLeft > 0
                    ? 'Request OTP in ${timerState.secondsLeft} s'
                    : '',
                style: TextStyle(color: Color(0xffa3a3a3)),
              ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            NextButton(
              buttonText: 'Submit',
              onPressed: () async {
                final isValid = _formKey.currentState!.validate();
                if (timerState.isRunning) {
                  messageTost(
                    'Request OTP in ${timerState.secondsLeft} s',
                    context,
                  );
                  return;
                }
                if (!isValid) {
                  messageTost('Fields shouldn\'t be empty', context);
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
                  } else {
                    final userInfo = UserModel(
                      phoneNumber: numberController.text,
                      name: controller.text,
                      code: selectedCountryCode,
                      type: "store",
                    );
                    try {
                      final result = await ref.read(sendOtpProvider(userInfo));

                      if (context.mounted) {
                        if (result.status) {
                          timerNotifier.start();
                          messageTost(result.message, context);
                          Future.delayed(const Duration(seconds: 2), () {
                            if (context.mounted) {
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VerifyOtpScreen(userInfo: userInfo),
                                  ),
                                );
                              }
                            }
                          });
                        } else {
                          messageTost(result.message, context);
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        messageTost(duration: 2, e.toString(), context);
                      }
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
