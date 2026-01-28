import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 28,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(width: 4),
        CircleAvatar(backgroundColor: Color(0xffD9D9D9), radius: 4),
        SizedBox(width: 4),
        CircleAvatar(backgroundColor: Color(0xffD9D9D9), radius: 4),
      ],
    );
  }
}
