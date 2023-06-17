import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/app/app_typedefs.dart';
import 'package:questionnaire/data/models/api_response.dart';
import 'package:questionnaire/data/models/questionnaire_model.dart';
import 'package:questionnaire/data/models/update_response.dart';
import 'package:questionnaire/data/states/questionnaire_state.dart';

import '../../app/app_constants.dart';
import '../../data/providers/api_manager.dart';

class QuestionnaireMapper {
  static const _languageTypeIdKey = "language_type_id";
  static const _likeQuestionKey = "like_question";
  static const _homeAssignmentDifficultTypeIdKey = "home_assignment_difficult_type_id";
  static const _homeAssignmentOtherKey = "home_assignment_other";

  static const _kotlinId = 0;
  static const _javaId = 1;
  static const _cppId = 2;

  static const _easyId = 0;
  static const _normalId = 1;
  static const _hardId = 2;
  static const _otherId = 3;

  QuestionnaireModel mapStateToModel(QuestionnaireState state) => QuestionnaireModel(
        languageType: state.languageType!,
        likeQuestionAnswer: state.likeQuestionAnswer,
        homeAssignmentDifficultType: state.homeAssignmentDifficultType!,
        homeAssignmentOther: state.homeAssignmentOther,
      );

  JsonMap mapModelToJson(QuestionnaireModel model) => {
        _languageTypeIdKey: _languageTypeId(model.languageType),
        _likeQuestionKey: model.likeQuestionAnswer,
        _homeAssignmentDifficultTypeIdKey: _difficultTypeId(model.homeAssignmentDifficultType),
        _homeAssignmentOtherKey: model.homeAssignmentOther,
      };

  int _languageTypeId(LanguageType languageType) {
    switch (languageType) {
      case LanguageType.kotlin:
        return _kotlinId;
      case LanguageType.java:
        return _javaId;
      case LanguageType.cpp:
        return _cppId;
    }
  }

  int _difficultTypeId(DifficultType homeAssignmentDifficultType) {
    switch (homeAssignmentDifficultType) {
      case DifficultType.easy:
        return _easyId;
      case DifficultType.normal:
        return _normalId;
      case DifficultType.hard:
        return _hardId;
      case DifficultType.other:
        return _otherId;
    }
  }

  UpdateResponse mapApiToUpdateResponse(ApiResponse apiResponse) => UpdateResponse(
        success: apiResponse.success,
        message: apiResponse.success ? AppConstants.successMessage : apiResponse.data[ApiManager.errorKey],
      );
}
