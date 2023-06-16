import 'package:get_it/get_it.dart';
import 'package:questionnaire/ui/questionnaire_widget.dart';

import '../ui/app.dart';

class WidgetsBindModule {
  static provide() {
    GetIt.I.registerFactory(() => const App());
    GetIt.I.registerFactory(() => const QuestionnaireWidget());
  }
}
