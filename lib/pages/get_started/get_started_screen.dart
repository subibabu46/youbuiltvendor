import 'package:design_task_1/pages/get_started/widgets/register_button.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/store_registration_screen.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';

enum BusinessType { store, service }

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  BusinessType? selectedType;
  @override
  Widget build(BuildContext context) {
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
                image: 'assets/ChatGPT Image Jan 27, 2026, 11_55_15 AM 1.png',
                width: 90,
                height: 80,
                onPressed: () {
                  setState(() {
                    selectedType = BusinessType.store;
                  });
                },
                isPressed: selectedType == BusinessType.store,
              ),
              SizedBox(height: 24),
              RegisterButton(
                title: 'Service Hub Registration',
                content: 'Register your service and list your \nofferings',
                image: 'assets/ChatGPT Image Jan 27, 2026, 11_55_15 AM 2.png',
                width: 77,
                height: 80,
                onPressed: () {
                  setState(() {
                    selectedType = BusinessType.service;
                  });
                },
                isPressed: selectedType == BusinessType.service,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
        child: NextButton(
          buttonText: 'Get Started',
          onPressed: () {
            if (selectedType == null) {
              messageTost("Please choose one to continue", context);
              return;
            }
            if (selectedType == BusinessType.store) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreRegistrationScreen(),
                ),
              );
            } else {}
          },
        ),
      ),
    );
  }
}
