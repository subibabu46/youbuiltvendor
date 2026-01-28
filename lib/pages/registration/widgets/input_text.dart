import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.controller,
    required this.hintText,
    this.isRequired = true,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isRequired;

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
                TextSpan(text: hintText),
                isRequired
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
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter details',
              hintStyle: TextStyle(
                color: Color(0xffa3a3a3),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Color(0xff737373)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Color(0xff737373)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
