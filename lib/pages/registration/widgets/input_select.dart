import 'package:flutter/material.dart';

class InputSelect extends StatelessWidget {
  const InputSelect({
    super.key,
    required this.hintText,
    this.isRequired = true,
  });

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
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0xff737373)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButton<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xffa3a3a3),
                ),
                isExpanded: true,
                underline: SizedBox(),
                value: 'Select details',
                items: ['Select details', '', ''].map((code) {
                  return DropdownMenuItem(value: code, child: Text(code));
                }).toList(),
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
