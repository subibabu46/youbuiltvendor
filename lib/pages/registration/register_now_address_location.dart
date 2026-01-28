import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/register_now_basic_info.dart';
import 'package:design_task_1/pages/registration/widgets/input_select.dart';
import 'package:design_task_1/pages/registration/widgets/input_text.dart';
import 'package:flutter/material.dart';

class RegisterNowAddressLocation extends StatelessWidget {
  const RegisterNowAddressLocation({super.key});

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
                  'Address & Location',
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

                InputSelect(hintText: 'Country'),
                InputText(controller: controller, hintText: 'Pin Code'),
                InputSelect(hintText: 'State'),
                InputSelect(hintText: 'District'),

                SizedBox(height: 80),
                NextButton(
                  buttonText: 'Next',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterNowBasicInfo(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
