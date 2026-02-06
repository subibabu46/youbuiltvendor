import 'package:design_task_1/constants/shared_pref_names.dart';
import 'package:design_task_1/models/register_step_1_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/pages/error/check_internet_screen.dart';
import 'package:design_task_1/pages/onboarding/widgets/next_button.dart';
import 'package:design_task_1/pages/store_registration/register_step_2_screen.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_number.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_select.dart';
import 'package:design_task_1/pages/store_registration/widgets/input_text.dart';
import 'package:design_task_1/pages/store_registration/widgets/steps_bubbles.dart';
import 'package:design_task_1/providers/connectivity_provider.dart';
import 'package:design_task_1/providers/shared_pref_provider.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _RegisterStep1Controllers {
  final businessName = TextEditingController();
  final ownerName = TextEditingController();
  final businessEmail = TextEditingController();
  final ownerEmail = TextEditingController();
  final companyOfficialNumber = TextEditingController();
  final phoneNumber = TextEditingController();
  final companyPanNumber = TextEditingController();
  final ownerPanNumber = TextEditingController();
  final gstNumber = TextEditingController();
  final ownerIdNumber = TextEditingController();
  void dispose() {
    businessName.dispose();
    ownerName.dispose();
    businessEmail.dispose();
    ownerEmail.dispose();
    companyOfficialNumber.dispose();
    phoneNumber.dispose();
    companyPanNumber.dispose();
    ownerPanNumber.dispose();
    gstNumber.dispose();
    ownerIdNumber.dispose();
  }
}

class RegisterStep1Screen extends ConsumerStatefulWidget {
  final UserModel userInfo;
  const RegisterStep1Screen({super.key, required this.userInfo});

  @override
  ConsumerState<RegisterStep1Screen> createState() =>
      _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends ConsumerState<RegisterStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  String? officialNumberCode, code, businessType;

  @override
  Widget build(BuildContext context) {
    final controllers = _RegisterStep1Controllers();
    controllers.ownerName.text = widget.userInfo.name;
    controllers.phoneNumber.text = widget.userInfo.phoneNumber;
    final countryCode = widget.userInfo.code;
    final businessTypesAsync = ref.watch(businessTypesProvider);
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Form(
                key: _formKey,
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
                    StepsBubbles(isEnable2: false),
                    SizedBox(height: 40),
                    InputText(
                      controller: controllers.businessName,
                      label: 'Business Name',
                    ),
                    InputText(
                      isEnabled: false,
                      controller: controllers.ownerName,
                      label: 'Owner Name',
                    ),
                    InputText(
                      controller: controllers.businessEmail,
                      label: 'Business Email',
                    ),
                    InputText(
                      controller: controllers.ownerEmail,
                      label: 'Owner Email',
                    ),
                    InputNumber(
                      controller: controllers.companyOfficialNumber,
                      label: 'Company Official Number',
                      isRequired: false,
                      onCountryCodeChanged: (value) =>
                          officialNumberCode = value,
                    ),
                    InputNumber(
                      isEnabled: false,
                      code: countryCode,
                      controller: controllers.phoneNumber,
                      label: 'Phone Number',
                    ),
                    InputText(
                      controller: controllers.companyPanNumber,
                      label: 'Company PAN Number',
                    ),
                    InputText(
                      controller: controllers.ownerPanNumber,
                      label: 'Owner PAN Number',
                    ),
                    InputText(
                      controller: controllers.gstNumber,
                      label: 'GST Number',
                    ),
                    InputText(
                      controller: controllers.ownerIdNumber,
                      label: 'Owner ID Number',
                    ),
                    InputSelect(
                      label: 'Business Type',
                      onSelectedString: (value) => businessType = value,
                      asyncList: businessTypesAsync,
                    ),
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
            if (!isValid || businessType == null) {
              messageTost('Fields shouldn\'t be empty', context);
            } else {
              final isConnected = await ref
                  .read(connectivityServiceProvider)
                  .isConnected();
              if (!isConnected) {
                if (context.mounted) {
                  messageTost("No internet connection", context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckInternetScreen(),
                    ),
                  );
                }
              } else {
                final registerStep1Info = RegisterStep1Model(
                  businessName: controllers.businessName.text,
                  ownerName: controllers.ownerName.text,
                  businessEmail: controllers.businessEmail.text,
                  ownerEmail: controllers.ownerEmail.text,
                  companyOfficialNumber: controllers.companyOfficialNumber.text,
                  phoneNumber: controllers.phoneNumber.text,
                  code: code ?? '+91',
                  companyPANNumber: controllers.companyPanNumber.text,
                  ownerPanNumber: controllers.ownerPanNumber.text,
                  gstNumber: controllers.gstNumber.text,
                  ownerIdNumber: controllers.ownerIdNumber.text,
                  type: 'store',
                  companyOfficialNumberCode: officialNumberCode ?? '+91',
                  businessType: businessType!,
                );
                try {
                  final result = await ref.read(
                    registerStep1Provider(registerStep1Info),
                  );
                  final pref = ref.watch(sharedPreferencesProvider).value;
                  pref?.setInt(stepId, result.data?['Id']);
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
                                builder: (context) => RegisterStep2Screen(),
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
            }
          },
        ),
      ),
    );
  }
}
