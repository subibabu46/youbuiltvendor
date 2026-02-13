import 'package:design_task_1/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 33,
            color: AppColors.textTitlePrimary,
          ),
        ),
        SizedBox(height: 10),
        Text(
          textAlign: TextAlign.center,
          content,
          style: TextStyle(
            color: AppColors.textOnboardingContent,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
