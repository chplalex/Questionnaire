import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/app/app_typedefs.dart';
import 'package:questionnaire/bl/mappers/option_mapper.dart';

import '../../data/models/option_model.dart';
import '../../data/models/question_model.dart';
import '../../data/states/question_state.dart';
import 'json_mapper.dart';

class QuestionMapper {
  static const _idKey = "id";
  static const _textKey = "text";
  static const _typeKey = "type";
  static const _optionsKey = "options";
  static const _isRequiredKey = "required";

  static const _mapTextToQuestionType = {
    "open": QuestionType.open,
    "close": QuestionType.close,
  };

  final JsonMapper _jsonMapper;
  final OptionMapper _optionMapper;

  const QuestionMapper(this._jsonMapper, this._optionMapper);

  List<QuestionModel> mapJsonListToQuestions(List<dynamic> jsonList) {
    return jsonList.map((jsonMap) => _mapJsonToModel(jsonMap)).toList(growable: false);
  }

  QuestionModel _mapJsonToModel(JsonMap jsonMap) => QuestionModel(
        id: _jsonMapper.mapToInt(jsonMap, _idKey),
        text: _jsonMapper.mapToString(jsonMap, _textKey),
        type: _mapToType(_jsonMapper.mapToString(jsonMap, _typeKey)),
        options: _mapToOptions(_jsonMapper.mapToNullableJsonList(jsonMap, _optionsKey)),
        isRequired: _jsonMapper.mapToBool(jsonMap, _isRequiredKey),
      );

  QuestionType _mapToType(String typeText) => _mapTextToQuestionType[typeText] ?? _unknownQuestionType(typeText);

  QuestionType _unknownQuestionType(String typeText) => throw Exception("Unknown question type $typeText");

  List<OptionModel>? _mapToOptions(List<JsonMap>? jsonList) {
    return jsonList?.map((itemJsonMap) => _optionMapper.mapJsonToModel(itemJsonMap)).toList(growable: false);
  }

  QuestionState mapModelToState(QuestionModel questionModel) => QuestionState(
        questionId: questionModel.id,
        questionType: questionModel.type,
        title: questionModel.text,
        isRequired: questionModel.isRequired,
        options: questionModel.options
            ?.map(
              (option) => _optionMapper.mapModelToState(option),
            )
            .toList(growable: false),
      );
}
