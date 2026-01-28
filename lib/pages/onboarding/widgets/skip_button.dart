import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
        color: Color(0xff0D0D0D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('Skip', style: TextStyle(color: Colors.white)),
    );
  }
}
