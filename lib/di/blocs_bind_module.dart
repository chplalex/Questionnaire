import 'package:get_it/get_it.dart';
import 'package:questionnaire/bl/questionnaire_cubit.dart';

class BlocsBindModule {
  static provide() {
    GetIt.I.registerFactory(() => QuestionnaireCubit());
  }
}
