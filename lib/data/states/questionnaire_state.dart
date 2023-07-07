import 'package:equatable/equatable.dart';

import 'question_state.dart';

class QuestionnaireState extends Equatable {
  final bool isLoading;
  final String? message;
  final bool isButtonEnabled;
  final List<QuestionState> questions;

  const QuestionnaireState({
    this.message,
    required this.isLoading,
    required this.isButtonEnabled,
    required this.questions,
  });

  factory QuestionnaireState.initial() => const QuestionnaireState(
        isLoading: true,
        isButtonEnabled: false,
        questions: [],
      );

  @override
  List<Object?> get props => [
        isLoading,
        message,
        isButtonEnabled,
        questions,
      ];

  QuestionnaireState copyWith({
    bool? isLoading,
    String? message,
    bool? isButtonEnabled,
    List<QuestionState>? questions,
  }) =>
      QuestionnaireState(
        message: message,
        isLoading: isLoading ?? this.isLoading,
        isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
        questions: questions ?? this.questions,
      );
}
