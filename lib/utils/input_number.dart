import 'package:design_task_1/constants/asset_names.dart';
import 'package:design_task_1/models/response_model.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:design_task_1/utils/colors_utils.dart';
import 'package:design_task_1/utils/message_toast.dart';
import 'package:design_task_1/utils/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputNumber extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool isFieldRequired;
  final bool isEnabled;
  final String code;
  final void Function(String)? onCountryCodeChanged;

  const InputNumber({
    super.key,
    required this.controller,
    this.hintText,
    required this.label,
    this.isFieldRequired = true,
    this.onCountryCodeChanged,
    this.isEnabled = true,
    this.code = '+91',
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputNumberState();
}

class _InputNumberState extends ConsumerState<InputNumber> {
  bool _hasError = false;

  String? selectedValue = '+91';
  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    final controller = widget.controller;
    final hintText = widget.hintText;
    final isFieldRequired = widget.isFieldRequired;

    final countryCodesAsync = ref.watch(countryCodesProvider);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              children: [
                TextSpan(text: label),
                isFieldRequired
                    ? TextSpan(
                        text: '*',
                        style: TextStyle(color: AppColors.textRequired),
                      )
                    : TextSpan(),
              ],
            ),
          ),

          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _hasError
                    ? AppColors.borderRequired
                    : AppColors.borderNormal,
              ),
            ),
            child: Row(
              children: [
                countryCodesAsync.when(
                  data: (result) {
                    final codes = result.data as List<GetModel>;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DropdownButton<String>(
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            AssetNames.arrowDown,
                            width: 20,
                            height: 20,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        underline: SizedBox(),
                        value: widget.isEnabled ? selectedValue : widget.code,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.textTitleSecondary,
                        ),
                        items: codes.map((code) {
                          return DropdownMenuItem(
                            value: code.label,
                            child: Text(code.label),
                          );
                        }).toList(),
                        onChanged: widget.isEnabled
                            ? (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                                if (value != null &&
                                    widget.onCountryCodeChanged != null) {
                                  widget.onCountryCodeChanged!(value);
                                }
                              }
                            : null,
                      ),
                    );
                  },
                  loading: () =>
                      ShimmerEffect(width: 50, height: 50, radius: 6),
                  error: (error, stack) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      messageTost('Something went wrong', context);
                    });

                    return Center(child: Text('+ '));
                  },
                ),
                SizedBox(width: 8),
                Container(width: 1, height: 24, color: AppColors.divider),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    enabled: widget.isEnabled,
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText ?? 'Enter details',
                      hintStyle: TextStyle(
                        color: AppColors.textHint,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      errorStyle: const TextStyle(height: 0, fontSize: 0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() => _hasError = true);
                        return 'Enter Your $label';
                      }

                      setState(() => _hasError = false);
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_hasError)
            Padding(
              padding: EdgeInsets.only(top: 4, left: 4),
              child: Text(
                '    Enter Your $label',
                style: TextStyle(color: AppColors.textRequired, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
