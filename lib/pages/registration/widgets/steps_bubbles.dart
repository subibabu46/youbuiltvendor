import 'package:design_task_1/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class StepsBubbles extends StatelessWidget {
  final bool isEnable2;

  const StepsBubbles({super.key, required this.isEnable2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _circle('1', true),
            _line(active: true),
            _circle('2', isEnable2),
            _line(active: false),
            _circle('3', false),
          ],
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _stepText('Basic Info', AppColors.textLabelBubbleActive),

            _stepText(
              'Address & Location',
              isEnable2
                  ? AppColors.textLabelBubbleActive
                  : AppColors.textLabelBubbleInactive,
            ),

            _stepText('Documents', AppColors.textLabelBubbleInactive),
          ],
        ),
      ],
    );
  }

  Widget _circle(String text, bool enabled) {
    return SizedBox(
      width: 60,
      child: Center(
        child: CircleAvatar(
          radius: 20,
          backgroundColor: enabled
              ? AppColors.bubbleActive
              : AppColors.bubbleInactive,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: enabled
                  ? AppColors.textBubbleActive
                  : AppColors.textBubbleInactive,
            ),
          ),
        ),
      ),
    );
  }

  Widget _line({required bool active}) {
    return Expanded(
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          color: active
              ? AppColors.bubbleDivActive
              : AppColors.bubbleDivInactive,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static Widget _stepText(String text, Color color) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: color),
    );
  }
}
