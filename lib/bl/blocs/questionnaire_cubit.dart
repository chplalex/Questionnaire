import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questionnaire/app/app_constants.dart';
import 'package:questionnaire/bl/mappers/questionnaire_mapper.dart';
import 'package:questionnaire/data/repositories/questionnaire_repository.dart';

import '../../app/app_enums.dart';
import '../../data/states/questionnaire_state.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  static const _portValueMin = 1025;
  static const _portValueMax = 65536;

  final QuestionnaireMapper _mapper;
  final QuestionnaireRepository _repository;

  var likeQuestionAnswer = "";
  var homeAssignmentOther = "";
  var authority = "";
  var port = "";

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

  void submitButtonPressed() async {
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

  void settingsButtonPressed() {
    final newState = state.copyWith(
      likeQuestionAnswer: likeQuestionAnswer,
      homeAssignmentOther: homeAssignmentOther,
    );
    emit(newState);
  }

  String? authorityValidator(String? value) =>
      value == null || value.trim().isEmpty ? AppConstants.authorityIsEmptyError : null;

  String? portValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    try {
      final portValue = int.parse(value);
      return portValue < _portValueMin || _portValueMax < portValue ? AppConstants.portRangeError : null;
    } catch (_) {
      return AppConstants.portNotIntegerError;
    }
  }

  void onNetworkSettingsApply() {
    AppConstants.questionnaireAuthority = authority.trim();
    AppConstants.questionnairePort = port.trim();
  }
}

extension _QuestionnaireStateExtension on QuestionnaireState {
  QuestionnaireState get check {
    final isCompleted = languageType != null && homeAssignmentDifficultType != null;
    return copyWith(isButtonEnabled: isCompleted, message: message);
  }
}
