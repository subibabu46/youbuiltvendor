import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/widgets/steps_bubbles.dart';
import 'package:design_task_1/pages/store_registration/widgets/upload_file.dart';
import 'package:flutter/material.dart';

class RegisterStep3Screen extends StatefulWidget {
  const RegisterStep3Screen({super.key});

  @override
  State<RegisterStep3Screen> createState() => _RegisterStep3ScreenState();
}

class _RegisterStep3ScreenState extends State<RegisterStep3Screen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                  StepsBubbles(isEnable2: true),
                  SizedBox(height: 40),
                  UploadFile(controller: controller, label: 'Business Logo'),
                  UploadFile(controller: controller, label: 'Company PAN Card'),
                  UploadFile(controller: controller, label: 'Owner PAN Card'),

                  UploadFile(controller: controller, label: 'Owner ID Card'),
                  UploadFile(controller: controller, label: 'GST Certificate'),

                  SizedBox(height: 24),

                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
        child: NextButton(buttonText: 'Confirm', onPressed: () {}),
      ),
    );
  }
}
