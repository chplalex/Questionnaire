import 'package:equatable/equatable.dart';

import '../../app/app_enums.dart';

class QuestionnaireState extends Equatable {
  final bool isLoading;
  final String? message;
  final LanguageType? languageType;
  final String likeQuestionAnswer;
  final DifficultType? homeAssignmentDifficultType;
  final String homeAssignmentOther;
  final bool homeAssignmentOtherIsEnable;
  final bool isButtonEnabled;

  const QuestionnaireState({
    this.message,
    required this.isLoading,
    required this.languageType,
    required this.likeQuestionAnswer,
    required this.homeAssignmentDifficultType,
    required this.homeAssignmentOther,
    required this.homeAssignmentOtherIsEnable,
    required this.isButtonEnabled,
  });

  factory QuestionnaireState.initial() => const QuestionnaireState(
        isLoading: false,
        languageType: null,
        likeQuestionAnswer: "",
        homeAssignmentDifficultType: null,
        homeAssignmentOther: "",
        homeAssignmentOtherIsEnable: false,
        isButtonEnabled: false,
      );

  @override
  List<Object?> get props => [
        isLoading,
        message,
        languageType,
        likeQuestionAnswer,
        homeAssignmentDifficultType,
        homeAssignmentOther,
        homeAssignmentOtherIsEnable,
        isButtonEnabled,
      ];

  QuestionnaireState copyWith({
    bool? isLoading,
    String? message,
    LanguageType? languageType,
    String? likeQuestionAnswer,
    DifficultType? homeAssignmentDifficultType,
    String? homeAssignmentOther,
    bool? homeAssignmentOtherIsEnable,
    bool? isButtonEnabled,
  }) =>
      QuestionnaireState(
        message: message,
        isLoading: isLoading ?? this.isLoading,
        languageType: languageType ?? this.languageType,
        likeQuestionAnswer: likeQuestionAnswer ?? this.likeQuestionAnswer,
        homeAssignmentDifficultType: homeAssignmentDifficultType ?? this.homeAssignmentDifficultType,
        homeAssignmentOther: homeAssignmentOther ?? this.homeAssignmentOther,
        homeAssignmentOtherIsEnable: homeAssignmentOtherIsEnable ?? this.homeAssignmentOtherIsEnable,
        isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      );
}
