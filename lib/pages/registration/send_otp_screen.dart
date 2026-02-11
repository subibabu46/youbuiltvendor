import 'package:design_task_1/helpers/check_connection.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/pages/login/login_screen.dart';
import 'package:design_task_1/utils/next_button.dart';
import 'package:design_task_1/providers/register_type_provider.dart';
import 'package:design_task_1/utils/input_number.dart';
import 'package:design_task_1/utils/input_text.dart';
import 'package:design_task_1/pages/registration/verify_otp_screen.dart';
import 'package:design_task_1/providers/timer_provider.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendOtpScreen extends ConsumerStatefulWidget {
  const SendOtpScreen({super.key});

  @override
  ConsumerState<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends ConsumerState<SendOtpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
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
    _scrollController.dispose();
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    String selectedCountryCode = '+91';
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: isKeyboardOpen
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
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
                                controller: nameController,
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

                    _BottomWidget(
                      formKey: _formKey,
                      nameController: nameController,
                      numberController: numberController,
                      selectedCountryCode: selectedCountryCode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomWidget extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController numberController;
  final String selectedCountryCode;
  const _BottomWidget({
    required this.formKey,
    required this.nameController,
    required this.numberController,
    required this.selectedCountryCode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(otpTimerProvider);
    final timerNotifier = ref.read(otpTimerProvider.notifier);
    final type = ref.read(registerTypeProvider).value;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
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
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
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
              final isValid = formKey.currentState!.validate();
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
                if (!await checkConnection(context, ref)) return;
                final userInfo = UserModel(
                  phoneNumber: numberController.text,
                  name: nameController.text,
                  code: selectedCountryCode,
                  type: type,
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
            },
          ),
          SizedBox(height: 88),
        ],
      ),
    );
  }
}
