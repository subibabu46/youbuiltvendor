import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final double width, height;
  final VoidCallback onPressed;
  final bool isPressed;
  const RegisterButton({
    super.key,
    required this.title,
    required this.content,
    required this.image,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 361,
        height: 108,
        decoration: BoxDecoration(
          border: Border.all(
            color: isPressed ? Color(0xffFF3B30) : Color(0xffD1D5DB),
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xff282828),
                    ),
                  ),
                  SizedBox(height: 4),

                  Text(
                    content,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff737373),
                    ),
                  ),
                ],
              ),

              Image.asset(image, width: width, height: height),
            ],
          ),
        ),
      ),
    );
  }
}
