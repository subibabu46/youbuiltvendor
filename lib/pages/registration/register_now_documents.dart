import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/widgets/sub_title_bubbles.dart';
import 'package:design_task_1/pages/registration/widgets/upload_file.dart';
import 'package:flutter/material.dart';

class RegisterNowDocuments extends StatelessWidget {
  const RegisterNowDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text(
                  'Registration',
                  style: TextStyle(
                    color: Color(0xff2c2c2c),
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: 8),
                SubTitleBubbles(isEnable2: true),
                SizedBox(height: 40),
                UploadFile(controller: controller, label: 'Business Logo'),
                UploadFile(controller: controller, label: 'Company PAN Card'),
                UploadFile(controller: controller, label: 'Owner PAN Card'),

                UploadFile(controller: controller, label: 'Owner ID Card'),
                UploadFile(controller: controller, label: 'GST Certificate'),

                SizedBox(height: 24),
                NextButton(buttonText: 'Confirm', onPressed: () {}),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
