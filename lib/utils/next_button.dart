import 'package:design_task_1/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.loading,
  });
  final VoidCallback onPressed;
  final String buttonText;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.buttonDefault,
          borderRadius: BorderRadius.circular(8),
        ),

        child: loading != null && loading == true
            ? Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(color: AppColors.loading),
                ),
              )
            : Text(
                buttonText,
                style: TextStyle(
                  color: AppColors.textButton,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
