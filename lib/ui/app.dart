import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:questionnaire/bl/blocs/questionnaire_cubit.dart';
import 'package:questionnaire/ui/questionnaire_widget.dart';
import 'package:questionnaire/app/app_constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
            create: (_) => GetIt.I.get<QuestionnaireCubit>(),
            child: GetIt.I.get<QuestionnaireWidget>(),
        ),
      );
}
