import 'package:flutter/material.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/data/states/question_state.dart';

import '../app/app_constants.dart';
import '../app/app_styles.dart';
import '../data/states/option_state.dart';
import 'questionnaire_text_field.dart';

class QuestionWidget extends StatefulWidget {
  final QuestionState state;

  const QuestionWidget({super.key, required this.state});

  @override
  State<QuestionWidget> createState() => _QuestionState();
}

class _QuestionState extends State<QuestionWidget> {
  static const _largePadding = 16.0;
  static const _normalPadding = 8.0;
  static const _cardRadius = 6.0;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return _questionCard(
      items: widget.state.questionType == QuestionType.open ? _openQuestionItems() : _closeQuestionItems(),
    );
  }

  Widget _questionCard({required List<Widget> items}) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_cardRadius)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: _cardRadius)],
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(_largePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardTitle(),
            ...items,
          ],
        ),
      );

  Widget _cardTitle() => Row(
        children: [
          Text(widget.state.title, style: AppStyles.title16),
          if (widget.state.isRequired) const Text(AppConstants.cardTitleAsterisk, style: AppStyles.title16Red),
        ],
      );

  List<Widget> _openQuestionItems() => [
        const SizedBox(height: _normalPadding),
        QuestionnaireTextField(
          controller: _controller,
          originalText: widget.state.text ?? "",
          hintText: AppConstants.openQuestionHint,
          isEnable: true,
          focusNode: _focusNode,
        ),
      ];

  List<Widget> _closeQuestionItems() {
    final selectedOptionId = _selectedOptionId(widget.state.options!);
    return widget.state.options!
        .map(
          (optionState) => _optionWidget(context, optionState: optionState, selectedOptionId: selectedOptionId),
        )
        .toList(growable: false);
  }

  Widget _optionWidget(BuildContext context, {required OptionState optionState, required int? selectedOptionId}) {
    return RadioListTile<int>(
      title: Text(optionState.title, style: AppStyles.text14Black),
      value: optionState.id,
      groupValue: selectedOptionId,
      contentPadding: EdgeInsets.zero,
      onChanged: (value) {
        setState(() {});
        FocusScope.of(context).unfocus();
      },
    );
  }

  int? _selectedOptionId(List<OptionState> optionStates) {
    try {
      return optionStates.firstWhere((element) => element.isSelected).id;
    } catch (_) {
      return null;
    }
  }
}
