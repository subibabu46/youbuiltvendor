import 'dart:io';

import 'package:design_task_1/constants/shared_pref_names.dart';
import 'package:design_task_1/helpers/check_connection.dart';
import 'package:design_task_1/models/register_step_3_model.dart';
import 'package:design_task_1/pages/home/home_screen.dart';
import 'package:design_task_1/utils/next_button.dart';
import 'package:design_task_1/pages/registration/widgets/steps_bubbles.dart';
import 'package:design_task_1/pages/registration/widgets/upload_file.dart';
import 'package:design_task_1/providers/shared_pref_provider.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterStep3Screen extends ConsumerStatefulWidget {
  const RegisterStep3Screen({super.key});

  @override
  ConsumerState<RegisterStep3Screen> createState() =>
      _RegisterStep3ScreenState();
}

class _RegisterStep3ScreenState extends ConsumerState<RegisterStep3Screen> {
  File? businessLogo;
  File? companyPanCard;
  File? ownerPanCard;
  File? ownerIdCard;
  File? gstCertificate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  Padding(
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
                        UploadFile(
                          label: 'Business Logo',
                          showFile: true,
                          onPressed: (value) => businessLogo = value,
                        ),
                        UploadFile(
                          label: 'Company PAN Card',
                          onPressed: (value) => companyPanCard = value,
                        ),
                        UploadFile(
                          label: 'Owner PAN Card',
                          onPressed: (value) => ownerPanCard = value,
                        ),

                        UploadFile(
                          label: 'Owner ID Card',
                          onPressed: (value) => ownerIdCard = value,
                        ),
                        UploadFile(
                          label: 'GST Certificate',
                          onPressed: (value) => gstCertificate = value,
                        ),

                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 64,
                      left: 16,
                      right: 16,
                    ),
                    child: NextButton(
                      buttonText: 'Confirm',
                      onPressed: _confirmCall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmCall() async {
    if (businessLogo == null ||
        companyPanCard == null ||
        ownerPanCard == null ||
        ownerIdCard == null ||
        gstCertificate == null) {
      messageTost('Fields shouldn\'t be empty', context);
    } else {
      if (!await checkConnection(context, ref)) return;

      final registerStepId = await SharedPrefCatch.instance.getInt(
        name: SharedPrefNames.stepId,
      );
      if (registerStepId == null) return;
      final registerStep3Info = RegisterStep3Model(
        businessLogo: businessLogo!,
        companyPanCard: companyPanCard!,
        ownerPanCard: ownerPanCard!,
        ownerIdCard: ownerIdCard!,
        gstCertificate: gstCertificate!,
      );
      try {
        final result = await ref.read(
          registerStep3Provider(
            RegisterStep3Params(
              model: registerStep3Info,
              stepId: registerStepId,
            ),
          ),
        );
        final pref = ref.watch(sharedPreferencesProvider).value;
        pref?.setInt(SharedPrefNames.level, result.data?['completedLevel']);
        pref?.setString(
          SharedPrefNames.accessToken,
          result.data?['accessToken'],
        );
        if (mounted) {
          if (result.status) {
            messageTost(result.message, context);
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              }
            });
          } else {
            messageTost(result.message, context);
          }
        }
      } catch (e) {
        if (mounted) {
          messageTost(duration: 2, e.toString(), context);
        }
      }
    }
  }
}
