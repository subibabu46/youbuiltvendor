import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadFile extends StatelessWidget {
  const UploadFile({
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
      padding: EdgeInsets.symmetric(vertical: 10),
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
          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              dashPattern: [6, 6],
              strokeWidth: 1,
              radius: Radius.circular(6),
              color: Color(0xffc1c1c1),
            ),
            child: Container(
              width: 361,
              height: 58,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xfff4f4f4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Vector.png', width: 24, height: 24),
                    SizedBox(width: 8),
                    Text(
                      'Upload File',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xffa3a3a3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
