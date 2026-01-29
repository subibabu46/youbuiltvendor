import 'package:flutter/material.dart';

class SubTitleBubbles extends StatelessWidget {
  final bool isEnable2;

  const SubTitleBubbles({super.key, required this.isEnable2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Color(0xff0d0d0d),

              radius: 20,
              child: Text(
                '1',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 100,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.black,

                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: isEnable2
                  ? Color(0xff0d0d0d)
                  : Color(0xfff4f4f4),
              radius: 20,
              child: Text(
                '2',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: isEnable2 ? Colors.white : Color(0xff737373),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 100,
              height: 3,
              decoration: BoxDecoration(
                color: Color(0xffd1d5db),

                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Color(0xfff4f4f4),
              radius: 20,
              child: Text(
                '3',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color(0xff737373),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Basic Info',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xff0d0d0d),
                ),
              ),
              Text(
                'Address & Location',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: isEnable2 ? Color(0xff0d0d0d) : Color(0xff737373),
                ),
              ),
              Text(
                'Documents',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xff737373),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
