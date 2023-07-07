import 'package:equatable/equatable.dart';

import '../../app/app_enums.dart';
import 'option_state.dart';

class QuestionState extends Equatable {
  final int questionId;
  final QuestionType questionType;
  final String title;
  final List<OptionState>? options;
  final String? text;
  final bool isRequired;

  const QuestionState({
    required this.questionId,
    required this.questionType,
    required this.title,
    this.options,
    this.text,
    required this.isRequired,
  });

  factory QuestionState.empty() => const QuestionState(
        questionId: -1,
        questionType: QuestionType.open,
        title: "",
        isRequired: false,
        text: "",
        options: [],
      );

  @override
  List<Object> get props => [
        questionId,
        questionType,
        title,
        if (options != null) options!,
        if (text != null) text!,
        isRequired,
      ];
}
