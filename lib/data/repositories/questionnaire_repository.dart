import 'package:questionnaire/bl/mappers/questionnaire_mapper.dart';
import 'package:questionnaire/data/models/questionnaire_model.dart';
import 'package:questionnaire/data/models/update_response.dart';
import 'package:questionnaire/data/providers/api_manager.dart';

class QuestionnaireRepository {
  final ApiManager _apiManager;
  final QuestionnaireMapper _mapper;

  const QuestionnaireRepository(this._apiManager, this._mapper);

  Future<UpdateResponse> updateQuestionnaire({required QuestionnaireModel model}) async {
    final jsonMap = _mapper.mapModelToJson(model);
    final apiResponse = await _apiManager.updateQuestionnaire(jsonMap);
    return _mapper.mapApiToUpdateResponse(apiResponse);
  }
}
