import 'package:questionnaire/data/models/api_response.dart';
import 'package:questionnaire/data/models/post_answers_response.dart';
import 'package:questionnaire/data/states/option_state.dart';
import 'package:questionnaire/data/states/question_state.dart';

import '../../app/app_constants.dart';
import '../../app/app_typedefs.dart';
import '../../data/models/answer_model.dart';
import '../../data/providers/api_manager.dart';

class AnswerMapper {
  static const _questionIdKey = "question_id";
  static const _optionIdKey = "option_id";
  static const _textKey = "text";

  AnswerModel mapStateToModel(QuestionState questionState) {
    final emptyOption = OptionState.empty();

    final selectedOption = questionState.options?.firstWhere(
          (optionState) => optionState.isSelected,
      orElse: () => emptyOption,
    );

    return AnswerModel(
      questionId: questionState.questionId,
      optionId: selectedOption?.id,
      text: selectedOption?.text,
    );
  }

  JsonList mapAnswersToJsonList(List<AnswerModel> answers) {
    return answers.map((model) => _mapModelToJson(model)).toList(growable: false);
  }

  JsonMap _mapModelToJson(AnswerModel model) {
    assert(
      model.text != null || model.optionId != null,
      "The answer with question id: ${model.questionId} has null for both option id and text",
    );
    return {
      _questionIdKey: model.questionId,
      if (model.optionId != null) _optionIdKey: model.optionId,
      if (model.text != null) _textKey: model.text,
    };
  }

  PostAnswersResponse mapApiToPostAnswersResponse(ApiResponse apiResponse) => PostAnswersResponse(
    success: apiResponse.success,
    message: apiResponse.success ? AppConstants.successMessage : apiResponse.data[ApiManager.errorKey],
  );
}
