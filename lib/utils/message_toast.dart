import 'package:design_task_1/utils/colors_utils.dart';
import 'package:flutter/material.dart';

void messageTost(String message, BuildContext context, {int? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: AppColors.textButton)),
      duration: Duration(seconds: duration ?? 2),
      backgroundColor: AppColors.textSecondary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
  );
}
