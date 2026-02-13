import 'package:design_task_1/pages/error/check_internet_screen.dart';
import 'package:design_task_1/utils/colors_utils.dart';
import 'package:design_task_1/utils/next_button.dart';
import 'package:design_task_1/utils/input_number.dart';
import 'package:design_task_1/providers/connectivity_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
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
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,

            physics: isKeyboardOpen
                ? const ScrollPhysics()
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
                              'Forgot \nPassword',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Enter your registered phone number',
                              style: TextStyle(
                                color: AppColors.textSecondary,
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
