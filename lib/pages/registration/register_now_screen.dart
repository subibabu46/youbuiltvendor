import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/register_now_address_location.dart';
import 'package:design_task_1/pages/registration/widgets/input_number.dart';
import 'package:design_task_1/pages/registration/widgets/input_text.dart';
import 'package:flutter/material.dart';

class RegisterNowScreen extends StatelessWidget {
  const RegisterNowScreen({super.key});

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
                InputText(controller: controller, hintText: 'Business Name'),
                InputText(controller: controller, hintText: 'Owner Name'),
                InputText(controller: controller, hintText: 'Business Email'),
                InputText(controller: controller, hintText: 'Owner Email'),
                InputNumber(
                  controller: controller,
                  hintText: 'Company Official Number',
                  isRequired: false,
                ),
                InputNumber(controller: controller, hintText: 'Phone Number'),
                InputText(
                  controller: controller,
                  hintText: 'Company PAN Number',
                ),
                InputText(controller: controller, hintText: 'Owner PAN Number'),
                InputText(controller: controller, hintText: 'GST Number'),
                InputText(controller: controller, hintText: 'Owner ID Number'),
                InputText(controller: controller, hintText: 'Owner ID Number'),
                SizedBox(height: 80),
                NextButton(
                  buttonText: 'Next',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterNowAddressLocation(),
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
