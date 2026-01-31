import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/register_now_address_location.dart';
import 'package:design_task_1/pages/registration/widgets/input_number.dart';
import 'package:design_task_1/pages/registration/widgets/input_text.dart';
import 'package:design_task_1/pages/registration/widgets/sub_title_bubbles.dart';
import 'package:flutter/material.dart';

class RegisterNowBasicInfo extends StatelessWidget {
  const RegisterNowBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                  SubTitleBubbles(isEnable2: false),
                  SizedBox(height: 40),
                  InputText(controller: controller, label: 'Business Name'),
                  InputText(controller: controller, label: 'Owner Name'),
                  InputText(controller: controller, label: 'Business Email'),
                  InputText(controller: controller, label: 'Owner Email'),
                  InputNumber(
                    controller: controller,
                    label: 'Company Official Number',
                    isRequired: false,
                  ),
                  InputNumber(controller: controller, label: 'Phone Number'),
                  InputText(
                    controller: controller,
                    label: 'Company PAN Number',
                  ),
                  InputText(controller: controller, label: 'Owner PAN Number'),
                  InputText(controller: controller, label: 'GST Number'),
                  InputText(controller: controller, label: 'Owner ID Number'),
                  InputText(controller: controller, label: 'Owner ID Number'),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
        child: NextButton(
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
      ),
    );
  }
}
