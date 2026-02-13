import 'package:design_task_1/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class RegisterTypeButton extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final double width, height;
  final VoidCallback onPressed;
  final bool isPressed;
  const RegisterTypeButton({
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
        width: MediaQuery.of(context).size.width,
        height: 108,
        decoration: BoxDecoration(
          border: Border.all(
            color: isPressed
                ? AppColors.borderRegisterType
                : AppColors.borderDefault,
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
                      color: AppColors.textTitleSecondary,
                    ),
                  ),
                  SizedBox(height: 4),

                  Text(
                    content,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              Flexible(
                child: Image.asset(image, width: width, height: height),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
