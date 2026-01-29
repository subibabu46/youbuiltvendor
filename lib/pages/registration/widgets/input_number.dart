import 'package:flutter/material.dart';

class InputNumber extends StatelessWidget {
  const InputNumber({
    super.key,
    required this.controller,
    this.hintText,
    required this.label,
    this.isRequired = true,
  });

  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0xffc1c1c1)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  DropdownButton<String>(
                    underline: SizedBox(),
                    value: '+91',
                    items: ['+1', '+91', '+44'].map((code) {
                      return DropdownMenuItem(value: code, child: Text(code));
                    }).toList(),
                    onChanged: (value) {},
                  ),
                  SizedBox(width: 8),
                  Container(width: 1, height: 24, color: Color(0xffe0e0e0)),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText ?? 'Enter details',
                        hintStyle: TextStyle(
                          color: Color(0xffa3a3a3),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
