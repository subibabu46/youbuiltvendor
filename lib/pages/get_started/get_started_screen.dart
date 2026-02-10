import 'package:design_task_1/helpers/check_connection.dart';
import 'package:design_task_1/pages/get_started/widgets/register_button.dart';
import 'package:design_task_1/utils/next_button.dart';
import 'package:design_task_1/providers/register_type_provider.dart';
import 'package:design_task_1/pages/registration/send_otp_screen.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetStartedScreen extends ConsumerStatefulWidget {
  const GetStartedScreen({super.key});

  @override
  ConsumerState<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends ConsumerState<GetStartedScreen> {
  RegisterType selectedType = RegisterType.none;
  @override
  Widget build(BuildContext context) {
    selectedType = ref.watch(registerTypeProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How would you like to \nget started?',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff2c2c2c),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Choose your business type',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xff737373),
                ),
              ),
              SizedBox(height: 60),
              RegisterButton(
                title: 'Store Registration',
                content: 'Register your store and list \nproducts',
                image: 'assets/shop 1.png',
                width: 90,
                height: 80,
                onPressed: () {
                  setState(() {
                    selectedType = RegisterType.store;
                    ref.read(registerTypeProvider.notifier).state =
                        RegisterType.store;
                  });
                },
                isPressed: selectedType == RegisterType.store,
              ),
              SizedBox(height: 24),
              RegisterButton(
                title: 'Service Hub Registration',
                content: 'Register your service and list your \nofferings',
                image: 'assets/mechanic1 1.png',
                width: 77,
                height: 80,
                onPressed: () {
                  setState(() {
                    selectedType = RegisterType.service;
                    ref.read(registerTypeProvider.notifier).state =
                        RegisterType.service;
                  });
                },
                isPressed: selectedType == RegisterType.service,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
        child: NextButton(
          buttonText: 'Get Started',
          onPressed: () async {
            if (selectedType == RegisterType.none) {
              messageTost("Please choose one to continue", context);
              return;
            }

            if (!await checkConnection(context, ref)) return;
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SendOtpScreen()),
              );
            }
          },
        ),
      ),
    );
  }
}
