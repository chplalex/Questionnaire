import 'package:equatable/equatable.dart';

import '../app/app_enums.dart';

class QuestionnaireState extends Equatable {
  final LanguageType? languageType;
  final String likeQuestionAnswer;
  final DifficultType? homeAssignmentDifficultType;
  final String homeAssignmentOther;
  final bool homeAssignmentOtherIsEnable;

  const QuestionnaireState({
    required this.languageType,
    required this.likeQuestionAnswer,
    required this.homeAssignmentDifficultType,
    required this.homeAssignmentOther,
    required this.homeAssignmentOtherIsEnable,
  });

  factory QuestionnaireState.initial() => const QuestionnaireState(
        languageType: null,
        likeQuestionAnswer: "",
        homeAssignmentDifficultType: null,
        homeAssignmentOther: "",
        homeAssignmentOtherIsEnable: false,
      );

  @override
  List<Object?> get props => [
        languageType,
        likeQuestionAnswer,
        homeAssignmentDifficultType,
        homeAssignmentOther,
        homeAssignmentOtherIsEnable,
      ];

  QuestionnaireState copyWith({
    LanguageType? languageType,
    String? likeQuestionAnswer,
    DifficultType? homeAssignmentDifficultType,
    String? homeAssignmentOther,
    bool? homeAssignmentOtherIsEnable,
  }) =>
      QuestionnaireState(
        languageType: languageType ?? this.languageType,
        likeQuestionAnswer: likeQuestionAnswer ?? this.likeQuestionAnswer,
        homeAssignmentDifficultType: homeAssignmentDifficultType ?? this.homeAssignmentDifficultType,
        homeAssignmentOther: homeAssignmentOther ?? this.homeAssignmentOther,
        homeAssignmentOtherIsEnable: homeAssignmentOtherIsEnable ?? this.homeAssignmentOtherIsEnable,
      );
}
