import 'package:design_task_1/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({
    super.key,
    required this.controller,
    this.hintText,
    required this.label,
    this.isFieldRequired = true,
    this.isEnabled = true,
    this.onChanged,
    this.keyboardType = TextInputType.name,
    this.isPasswordMode = false,
  });

  final TextEditingController controller;
  final bool isPasswordMode;
  final String? hintText;
  final String label;
  final bool isFieldRequired;
  final bool isEnabled;
  final Function(String)? onChanged;
  final TextInputType keyboardType;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool _isEyeVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              children: [
                TextSpan(text: widget.label),
                widget.isFieldRequired
                    ? TextSpan(
                        text: '*',
                        style: TextStyle(color: AppColors.textRequired),
                      )
                    : TextSpan(),
              ],
            ),
          ),

          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: widget.keyboardType,
                  enabled: widget.isEnabled,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  obscureText: !_isEyeVisible && widget.isPasswordMode,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: AppColors.textRequired),
                    hintText: widget.hintText ?? 'Enter details',
                    hintStyle: TextStyle(
                      color: AppColors.textHint,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: widget.isPasswordMode
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _isEyeVisible = !_isEyeVisible;
                              });
                            },
                            icon: Icon(
                              color: AppColors.textHint,
                              _isEyeVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          )
                        : null,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: AppColors.borderNormal),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: AppColors.borderNormal),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: AppColors.borderNormal),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        color: AppColors.borderRequired,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        color: AppColors.borderRequired,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Your ${widget.label}';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
