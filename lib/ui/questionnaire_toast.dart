import 'package:flutter/material.dart';
import 'package:questionnaire/app/app_styles.dart';

import '../app/app_colors.dart';

class QuestionnaireToast extends StatelessWidget {
  static const _horizontalPadding = 24.0;
  static const _verticalPadding = 12.0;
  static const _borderRadius = 20.0;
  static const _borderWidth = 0.5;

  final String text;

  const QuestionnaireToast({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding, vertical: _verticalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(color: AppColors.lightPaleBlue, width: _borderWidth),
        color: AppColors.pastelBlue,
      ),
      child: Text(
        text,
        style: AppStyles.toast,
        textAlign: TextAlign.center,
      ),
    );
  }
}
