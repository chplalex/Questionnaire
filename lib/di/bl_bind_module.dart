import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:questionnaire/bl/blocs/questionnaire_cubit.dart';

import '../bl/mappers/answer_mapper.dart';
import '../bl/mappers/json_mapper.dart';
import '../bl/mappers/option_mapper.dart';
import '../bl/mappers/question_mapper.dart';
import '../data/providers/api_manager.dart';
import '../data/repositories/questionnaire_repository.dart';

class BlBindModule {
  static provide() {
    GetIt.I.registerFactory(() => ApiManager(GetIt.I.get()));
    GetIt.I.registerFactory(() => Client());
    GetIt.I.registerFactory(() => QuestionnaireCubit(GetIt.I.get(), GetIt.I.get(), GetIt.I.get()));
    GetIt.I.registerFactory(() => QuestionMapper(GetIt.I.get(), GetIt.I.get()));
    GetIt.I.registerFactory(() => JsonMapper());
    GetIt.I.registerFactory(() => OptionMapper(GetIt.I.get()));
    GetIt.I.registerFactory(() => AnswerMapper());
    GetIt.I.registerFactory(() => QuestionnaireRepository(GetIt.I.get(), GetIt.I.get(), GetIt.I.get()));
  }
}
