import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questionnaire/app/app_constants.dart';
import 'package:questionnaire/bl/mappers/question_mapper.dart';
import 'package:questionnaire/data/repositories/questionnaire_repository.dart';

import '../../data/states/questionnaire_state.dart';
import '../mappers/answer_mapper.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  static const _portValueMin = 1025;
  static const _portValueMax = 65536;

  final QuestionMapper _questionMapper;
  final AnswerMapper _answerMapper;
  final QuestionnaireRepository _repository;

  var authority = "";
  var port = "";

  QuestionnaireCubit(this._questionMapper, this._answerMapper, this._repository) : super(QuestionnaireState.initial());

  void init() async {
    try {
      final questionModels = await _repository.getQuestions();
      final questionStates = questionModels
          .map(
            (model) => _questionMapper.mapModelToState(model),
          )
          .toList(growable: false);
      final newState = QuestionnaireState(isLoading: false, isButtonEnabled: false, questions: questionStates);
      emit(newState);
    } on Exception catch (error) {
      final newState = state.copyWith(isLoading: false, message: error.toString());
      emit(newState);
    }
  }

  void submitButtonPressed() async {
    emit(state.copyWith(isLoading: true));

    final answers = state.questions
        .map(
          (questionState) => _answerMapper.mapStateToModel(questionState),
        )
        .toList(growable: false);

    final response = await _repository.postAnswers(answers: answers);

    final newState = state.copyWith(isLoading: false, message: response.message);
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
    return copyWith(isButtonEnabled: false, message: message);
  }
}
