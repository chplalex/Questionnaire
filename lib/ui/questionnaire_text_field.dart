import 'package:flutter/material.dart';
import 'package:questionnaire/app/app_styles.dart';

class QuestionnaireTextField extends StatelessWidget {
  final TextEditingController controller;
  final String originalText;
  final String? hintText;
  final bool isEnable;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;

  const QuestionnaireTextField({
    super.key,
    required this.controller,
    required this.originalText,
    this.hintText,
    required this.isEnable,
    required this.focusNode,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = originalText;
    controller.selection = TextSelection.collapsed(offset: originalText.length);
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      readOnly: !isEnable,
      controller: controller,
      style: isEnable ? AppStyles.text14Black : AppStyles.text14BlackNotEnabled,
      decoration: InputDecoration(hintText: hintText, contentPadding: EdgeInsets.zero),
      focusNode: focusNode,
      validator: validator,
      autovalidateMode: validator == null ? null : AutovalidateMode.onUserInteraction,
    );
  }
}
