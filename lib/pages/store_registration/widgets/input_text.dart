import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.controller,
    this.hintText,
    required this.label,
    this.isFieldRequired = true, this.isEnabled=true,
  });

  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool isFieldRequired;
  final bool isEnabled;

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
                TextSpan(text: label),
                isFieldRequired
                    ? TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red),
                      )
                    : TextSpan(),
              ],
            ),
          ),

          SizedBox(height: 8),
          TextFormField(
            enabled: isEnabled,
            controller: controller,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red),
              hintText: hintText ?? 'Enter details',
              hintStyle: TextStyle(
                color: Color(0xffa3a3a3),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Color(0xffc1c1c1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Color(0xffc1c1c1)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Color(0xffc1c1c1)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Your $label';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
