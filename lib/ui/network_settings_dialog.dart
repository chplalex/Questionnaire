import 'package:flutter/material.dart';
import 'package:questionnaire/app/app_constants.dart';
import 'package:questionnaire/app/app_styles.dart';
import 'package:questionnaire/ui/questionnaire_text_field.dart';

import '../app/app_colors.dart';

class NetworkSettingsDialog {
  static const _borderRadius = 6.0;
  static const _borderWidth = 0.5;
  static const _paddingLarge = 16.0;
  static const _paddingNormal = 8.0;

  final TextEditingController authorityController;
  final TextEditingController portController;

  final FormFieldValidator<String> authorityValidator;
  final FormFieldValidator<String> portValidator;

  final VoidCallback onApply;

  final _formKey = GlobalKey<FormState>();

  NetworkSettingsDialog({
    required this.authorityController,
    required this.authorityValidator,
    required this.portController,
    required this.portValidator,
    required this.onApply,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: _dialogBuilder,
    );
  }

  Widget _dialogBuilder(BuildContext context) {
    return AlertDialog(
      title: const Text(AppConstants.networkSettingsDialogTitle, style: AppStyles.title28),
      titlePadding: const EdgeInsets.all(_paddingLarge),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textInput(
              label: AppConstants.networkSettingsDialogLabelAuthority,
              originalText: AppConstants.questionnaireAuthority,
              controller: authorityController,
              validator: authorityValidator,
            ),
            const SizedBox(height: 2 * _paddingLarge),
            _textInput(
              label: AppConstants.networkSettingsDialogLabelPort,
              originalText: AppConstants.questionnairePort,
              controller: portController,
              validator: portValidator,
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.all(_paddingLarge),
      actions: [
        _buttonApply(context),
        _buttonCancel(context),
      ],
      actionsPadding: const EdgeInsets.all(_paddingLarge),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          side: const BorderSide(width: _borderWidth, color: AppColors.lightPaleBlue)),
    );
  }

  static Widget _textInput({
    required String label,
    required String originalText,
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label:", style: AppStyles.title16),
          const SizedBox(height: _paddingNormal),
          QuestionnaireTextField(
            controller: controller,
            originalText: originalText,
            isEnable: true,
            focusNode: null,
            validator: validator,
          ),
        ],
      );

  Widget _buttonApply(BuildContext context) => ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            onApply.call();
            Navigator.of(context).pop();
          }
        },
        child: const Text(AppConstants.buttonLabelApply),
      );

  Widget _buttonCancel(BuildContext context) => TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text(AppConstants.buttonLabelCancel),
      );
}
