import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questionnaire/bl/mappers/questionnaire_mapper.dart';
import 'package:questionnaire/data/repositories/questionnaire_repository.dart';

import '../../app/app_enums.dart';
import '../../data/states/questionnaire_state.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  final QuestionnaireMapper _mapper;
  final QuestionnaireRepository _repository;

  var likeQuestionAnswer = "";
  var homeAssignmentOther = "";

  QuestionnaireCubit(this._mapper, this._repository) : super(QuestionnaireState.initial());

  void languageChanged(LanguageType? languageType) {
    final newState = state
        .copyWith(
          languageType: languageType,
          likeQuestionAnswer: likeQuestionAnswer,
          homeAssignmentOther: homeAssignmentOther,
        )
        .check;

    emit(newState);
  }

  void difficultyChanged(DifficultType? difficultType) {
    final newState = state
        .copyWith(
          homeAssignmentDifficultType: difficultType,
          likeQuestionAnswer: likeQuestionAnswer,
          homeAssignmentOther: homeAssignmentOther,
          homeAssignmentOtherIsEnable: difficultType == DifficultType.other,
        )
        .check;

    emit(newState);
  }

  void submitQuestionnaire() async {
    final loadingState = state.copyWith(
      isLoading: true,
      likeQuestionAnswer: likeQuestionAnswer,
      homeAssignmentOther: homeAssignmentOther,
    );
    emit(loadingState);

    final submitState = state.copyWith(
      likeQuestionAnswer: likeQuestionAnswer,
      homeAssignmentOther: state.homeAssignmentDifficultType == DifficultType.other ? homeAssignmentOther : "",
    );
    final submitModel = _mapper.mapStateToModel(submitState);
    final response = await _repository.updateQuestionnaire(model: submitModel);

    final newState = response.success
        ? QuestionnaireState.initial()
        : state.copyWith(
            isLoading: false,
            likeQuestionAnswer: likeQuestionAnswer,
            homeAssignmentOther: homeAssignmentOther,
          );
    emit(newState.copyWith(message: response.message));
  }
}

extension _QuestionnaireStateExtension on QuestionnaireState {
  QuestionnaireState get check {
    final isCompleted = languageType != null && homeAssignmentDifficultType != null;
    return copyWith(isButtonEnabled: isCompleted, message: message);
  }
}
