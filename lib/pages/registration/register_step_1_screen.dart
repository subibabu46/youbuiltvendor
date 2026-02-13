import 'package:design_task_1/constants/shared_pref_names.dart';
import 'package:design_task_1/helpers/check_connection.dart';
import 'package:design_task_1/models/register_step_1_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/utils/colors_utils.dart';
import 'package:design_task_1/utils/next_button.dart';
import 'package:design_task_1/providers/register_type_provider.dart';
import 'package:design_task_1/pages/registration/register_step_2_screen.dart';
import 'package:design_task_1/utils/input_number.dart';
import 'package:design_task_1/utils/input_select.dart';
import 'package:design_task_1/utils/input_text.dart';
import 'package:design_task_1/pages/registration/widgets/steps_bubbles.dart';
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
  final controllers = _RegisterStep1Controllers();
  String? officialNumberCode;
  String? code;
  String? businessType;
  @override
  void initState() {
    controllers.ownerName.text = widget.userInfo.name;
    controllers.phoneNumber.text = widget.userInfo.phoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countryCode = widget.userInfo.code;
    final businessTypesAsync = ref.watch(businessTypesProvider);

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Registration',
                            style: TextStyle(
                              color: AppColors.textPrimary,
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
                            isFieldRequired: false,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 64,
                      left: 16,
                      right: 16,
                    ),
                    child: NextButton(buttonText: 'Next', onPressed: _nextCall),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _nextCall() async {
    final isValid = _formKey.currentState!.validate();

    final type = ref.read(registerTypeProvider).value;
    if (!isValid || businessType == null) {
      messageTost('Fields shouldn\'t be empty', context);
    } else {
      if (!await checkConnection(context, ref)) return;
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
        type: type,
        companyOfficialNumberCode: officialNumberCode ?? '+91',
        businessType: businessType!,
      );
      try {
        final result = await ref.read(registerStep1Provider(registerStep1Info));
        final pref = ref.watch(sharedPreferencesProvider).value;
        pref?.setInt(SharedPrefNames.stepId, result.data?['Id']);
        pref?.setInt(SharedPrefNames.level, result.data?['completedLevel']);
        if (mounted) {
          if (result.status) {
            messageTost(result.message, context);
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
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
        if (mounted) {
          messageTost(duration: 2, e.toString(), context);
        }
      }
    }
  }
}
