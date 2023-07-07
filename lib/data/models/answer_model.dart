import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final int questionId;
  final int? optionId;
  final String? text;

  const AnswerModel({
    required this.questionId,
    required this.optionId,
    required this.text,
  });

  @override
  List<Object> get props => [
    questionId,
    if (optionId != null) optionId!,
    if (text != null) text!,
  ];
}
