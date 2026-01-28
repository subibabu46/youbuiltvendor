import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/widgets/input_text.dart';
import 'package:flutter/material.dart';

class RegisterNowBasicInfo extends StatelessWidget {
  const RegisterNowBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registration',
                  style: TextStyle(
                    color: Color(0xff2c2c2c),
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Basic Info',
                  style: TextStyle(
                    color: Color(0xff737373),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                InputText(controller: controller, hintText: 'Address 1'),
                InputText(controller: controller, hintText: 'Address 2'),
                InputText(controller: controller, hintText: 'Location'),

                InputText(controller: controller, hintText: 'Country'),
                InputText(controller: controller, hintText: 'Pin Code'),
                InputText(controller: controller, hintText: 'State'),
                InputText(controller: controller, hintText: 'District'),

                SizedBox(height: 80),
                NextButton(buttonText: 'Confirm', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
