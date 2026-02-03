import 'dart:developer';

import 'package:design_task_1/constants/shared_pref_names.dart';
import 'package:design_task_1/models/register_step_2_model.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/register_step_3_screen.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_select.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_text.dart';
import 'package:design_task_1/pages/store_registration/widgets/steps_bubbles.dart';
import 'package:design_task_1/providers/shared_pref_provider.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _RegisterStep2Controllers {
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final location = TextEditingController();
  final pinCode = TextEditingController();
  void dispose() {
    address1.dispose();
    address2.dispose();
    location.dispose();
    pinCode.dispose();
  }
}

class RegisterStep2Screen extends ConsumerStatefulWidget {
  const RegisterStep2Screen({super.key});

  @override
  ConsumerState<RegisterStep2Screen> createState() =>
      _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends ConsumerState<RegisterStep2Screen> {
  String? country, state, district, pinCode;
  final _formKey = GlobalKey<FormState>();
  final controllers = _RegisterStep2Controllers();
  @override
  Widget build(BuildContext context) {
    final countriesAsync = ref.watch(countriesProvider);

    final statesAsync = pinCode != null && pinCode!.isNotEmpty
        ? ref.watch(statesProvider(controllers.pinCode.text))
        : null;
    final districtsAsync = pinCode != null && pinCode!.isNotEmpty
        ? ref.watch(districtsProvider(controllers.pinCode.text))
        : null;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
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
                    InputText(
                      controller: controllers.address1,
                      label: 'Address 1',
                    ),
                    InputText(
                      controller: controllers.address2,
                      label: 'Address 2',
                    ),
                    InputText(
                      controller: controllers.location,
                      label: 'Location',
                    ),

                    InputSelect(
                      label: 'Country',
                      onSelected: (value) => country = value,
                      asyncList: countriesAsync,
                    ),
                    InputText(
                      controller: controllers.pinCode,
                      label: 'Pin Code',
                      onChanged: (value) {
                        if (value.length == 6) {
                          setState(() {
                            pinCode = value;
                          });
                        }
                      },
                    ),
                    InputSelect(
                      label: 'State',
                      onSelected: (value) => state = value,
                      asyncList: statesAsync,
                    ),
                    InputSelect(
                      label: 'District',
                      onSelected: (value) => district = value,
                      asyncList: districtsAsync,
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
        child: NextButton(
          buttonText: 'Next',
          onPressed: () async {
            final isValid = _formKey.currentState!.validate();
            if (!isValid ||
                country == null ||
                state == null ||
                district == null) {
              messageTost('Fields shouldn\'t be empty', context);
            } else {
              final registerStep1Id = await SharedPrefCatch.instance.getInt(
                name: stepId,
              );
              log(registerStep1Id.toString());
              if (registerStep1Id == null) return;
              final registerStep2Info = RegisterStep2Model(
                address1: controllers.address1.text,
                address2: controllers.address2.text,
                location: controllers.location.text,
                country: country!,
                pinCode: controllers.pinCode.text,
                state: state!,
                district: district!,
              );
              try {
                final result = await ref.read(
                  registerStep2Provider(
                    RegisterStep2Params(
                      model: registerStep2Info,
                      step1Id: registerStep1Id,
                    ),
                  ),
                );
                final pref = ref.watch(sharedPreferencesProvider).value;
                pref?.setInt(level, result.data?['completedLevel']);
                if (context.mounted) {
                  if (result.status) {
                    messageTost(result.message, context);
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterStep3Screen(),
                            ),
                          );
                        }
                      }
                    });
                  } else {
                    messageTost(result.message, context);
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  messageTost(duration: 2, e.toString(), context);
                }
              }
            }
          },
        ),
      ),
    );
  }
}
