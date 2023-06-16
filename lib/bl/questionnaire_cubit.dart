import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/app_enums.dart';
import 'questionnaire_state.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  var likeQuestionAnswer = "";
  var homeAssignmentOther = "";

  QuestionnaireCubit() : super(QuestionnaireState.initial());

  void languageChanged(LanguageType? languageType) {
    final newState = state.copyWith(
      languageType: languageType,
      likeQuestionAnswer: likeQuestionAnswer,
      homeAssignmentOther: homeAssignmentOther,
    );

    emit(newState);
  }

  void difficultyChanged(DifficultType? difficultType) {
    final newState = state.copyWith(
      homeAssignmentDifficultType: difficultType,
      likeQuestionAnswer: likeQuestionAnswer,
      homeAssignmentOther: homeAssignmentOther,
      homeAssignmentOtherIsEnable: difficultType == DifficultType.other,
    );

    emit(newState);
  }
}
