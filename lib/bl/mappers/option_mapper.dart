import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/app/app_typedefs.dart';

import '../../data/models/option_model.dart';
import '../../data/states/option_state.dart';
import 'json_mapper.dart';

class OptionMapper {
  static const _idKey = "id";
  static const _textKey = "text";
  static const _typeKey = "type";

  static const _mapTextToOptionType = {
    "open": OptionType.open,
    "close": OptionType.close,
  };

  final JsonMapper _jsonMapper;

  const OptionMapper(this._jsonMapper);

  OptionModel mapJsonToModel(JsonMap jsonMap) => OptionModel(
        id: _jsonMapper.mapToInt(jsonMap, _idKey),
        text: _jsonMapper.mapToString(jsonMap, _textKey),
        type: _mapToType(_jsonMapper.mapToString(jsonMap, _typeKey)),
      );

  OptionType _mapToType(String typeText) => _mapTextToOptionType[typeText] ?? _unknownOptionType(typeText);

  _unknownOptionType(String typeText) => throw Exception("Unknown option type $typeText");

  OptionState mapModelToState(OptionModel optionModel) => OptionState(
        id: optionModel.id,
        type: optionModel.type,
        title: optionModel.text,
        isSelected: false,
      );
}
