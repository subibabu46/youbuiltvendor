import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/registration/register_now_documents.dart';
import 'package:design_task_1/pages/registration/widgets/input_select.dart';
import 'package:design_task_1/pages/registration/widgets/input_text.dart';
import 'package:design_task_1/pages/registration/widgets/sub_title_bubbles.dart';
import 'package:flutter/material.dart';

class RegisterNowAddressLocation extends StatefulWidget {
  const RegisterNowAddressLocation({super.key});

  @override
  State<RegisterNowAddressLocation> createState() =>
      _RegisterNowAddressLocationState();
}

class _RegisterNowAddressLocationState
    extends State<RegisterNowAddressLocation> {
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
                  SubTitleBubbles(isEnable2: true),
                  SizedBox(height: 40),
                  InputText(controller: controller, label: 'Address 1'),
                  InputText(controller: controller, label: 'Address 2'),
                  InputText(controller: controller, label: 'Location'),

                  InputSelect(label: 'Country'),
                  InputText(controller: controller, label: 'Pin Code'),
                  InputSelect(label: 'State'),
                  InputSelect(label: 'District'),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
        child: NextButton(
          buttonText: 'Next',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterNowDocuments()),
            );
          },
        ),
      ),
    );
  }
}
