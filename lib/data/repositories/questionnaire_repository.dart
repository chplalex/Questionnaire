import 'package:questionnaire/data/models/post_answers_response.dart';
import 'package:questionnaire/data/models/question_model.dart';
import 'package:questionnaire/data/providers/api_manager.dart';

import '../../bl/mappers/answer_mapper.dart';
import '../../bl/mappers/question_mapper.dart';
import '../models/answer_model.dart';

class QuestionnaireRepository {
  final ApiManager _apiManager;
  final QuestionMapper _questionMapper;
  final AnswerMapper _answerMapper;

  const QuestionnaireRepository(this._apiManager, this._questionMapper, this._answerMapper);

  Future<List<QuestionModel>> getQuestions() => _apiManager.getQuestions().then((apiResponse) {
    return apiResponse.success
      ? _questionMapper.mapJsonListToQuestions(apiResponse.data[ApiManager.questionsKey])
      : throw Exception(apiResponse.data[ApiManager.errorKey]);
  });

  Future<PostAnswersResponse> postAnswers({required List<AnswerModel> answers}) async {
    final jsonList = _answerMapper.mapAnswersToJsonList(answers);
    final apiResponse = await _apiManager.postAnswers({ApiManager.answersKey: jsonList});
    return _answerMapper.mapApiToPostAnswersResponse(apiResponse);
  }
}
