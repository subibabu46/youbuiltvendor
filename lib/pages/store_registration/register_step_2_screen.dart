import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/register_step_3_screen.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_select.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_text.dart';
import 'package:design_task_1/pages/store_registration/widgets/steps_bubbles.dart';
import 'package:flutter/material.dart';

class RegisterStep2Screen extends StatefulWidget {
  const RegisterStep2Screen({super.key});

  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  TextEditingController controller = TextEditingController();
  String? country, state, district;
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
                  InputText(controller: controller, label: 'Address 1'),
                  InputText(controller: controller, label: 'Address 2'),
                  InputText(controller: controller, label: 'Location'),

                  InputSelect(
                    label: 'Country',
                    onSelected: (value) => country = value,
                  ),
                  InputText(controller: controller, label: 'Pin Code'),
                  InputSelect(
                    label: 'State',
                    onSelected: (value) => state = value,
                  ),
                  InputSelect(
                    label: 'District',
                    onSelected: (value) => district = value,
                  ),
                  SizedBox(height: 24),
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
              MaterialPageRoute(builder: (context) => RegisterStep3Screen()),
            );
          },
        ),
      ),
    );
  }
}
