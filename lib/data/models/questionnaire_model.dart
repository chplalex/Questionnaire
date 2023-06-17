import 'package:equatable/equatable.dart';

import '../../app/app_enums.dart';

class QuestionnaireModel extends Equatable {
  final LanguageType languageType;
  final String likeQuestionAnswer;
  final DifficultType homeAssignmentDifficultType;
  final String homeAssignmentOther;

  const QuestionnaireModel({
    required this.languageType,
    required this.likeQuestionAnswer,
    required this.homeAssignmentDifficultType,
    required this.homeAssignmentOther,
  });

  @override
  List<Object?> get props => [
        languageType,
        likeQuestionAnswer,
        homeAssignmentDifficultType,
        homeAssignmentOther,
      ];
}
