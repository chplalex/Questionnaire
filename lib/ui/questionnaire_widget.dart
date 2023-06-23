import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:questionnaire/app/app_constants.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/app/app_styles.dart';
import 'package:questionnaire/bl/blocs/questionnaire_cubit.dart';
import 'package:questionnaire/data/states/questionnaire_state.dart';
import 'package:questionnaire/ui/questionnaire_text_field.dart';
import 'package:questionnaire/ui/questionnaire_toast.dart';

import '../app/app_colors.dart';
import 'network_settings_dialog.dart';

class QuestionnaireWidget extends StatefulWidget {
  const QuestionnaireWidget({super.key});

  @override
  State<StatefulWidget> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<QuestionnaireWidget> {
  static const _largePadding = 16.0;
  static const _normalPadding = 8.0;
  static const _smallPadding = 4.0;
  static const _topLineHeight = 10.0;
  static const _cardRadius = 6.0;
  static const _progressIndicatorSize = 50.0;
  static const _loadingWidgetOpacity = 0.5;

  late final QuestionnaireCubit _cubit;

  final _authorityController = TextEditingController();
  final _homeAssignmentController = TextEditingController();
  final _likeQuestionController = TextEditingController();
  final _portController = TextEditingController();

  final _likeQuestionFocusNode = FocusNode();
  final _homeAssignmentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);

    _likeQuestionController.addListener(() {
      _cubit.likeQuestionAnswer = _likeQuestionController.text;
    });

    _homeAssignmentController.addListener(() {
      _cubit.homeAssignmentOther = _homeAssignmentController.text;
    });

    _authorityController.addListener(() {
      _cubit.authority = _authorityController.text;
    });

    _portController.addListener(() {
      _cubit.port = _portController.text;
    });
  }

  @override
  void dispose() {
    _likeQuestionController.dispose();
    _homeAssignmentController.dispose();

    _likeQuestionFocusNode.dispose();
    _homeAssignmentFocusNode.dispose();

    _authorityController.dispose();
    _portController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(child: _body(context)),
      );

  Widget _body(BuildContext context) {
    return BlocConsumer<QuestionnaireCubit, QuestionnaireState>(
      listener: (context, state) => _showToast(context, state.message!),
      listenWhen: (_, state) => state.message != null,
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            _mainWidget(context, state),
            if (state.isLoading) ..._loadingWidget(),
          ],
        );
      },
    );
  }

  List<Widget> _loadingWidget() => [
        Container(color: Colors.black.withOpacity(_loadingWidgetOpacity)),
        const SizedBox(
          width: _progressIndicatorSize,
          height: _progressIndicatorSize,
          child: CircularProgressIndicator(),
        ),
      ];

  Widget _mainWidget(BuildContext context, QuestionnaireState state) {
    const divider = SizedBox(height: _normalPadding);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(_largePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleCard(),
          divider,
          _languageCard(context, state),
          divider,
          _likeQuestionCard(state),
          divider,
          _homeAssignmentCard(context, state),
          divider,
          _actionRow(context, state),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: QuestionnaireToast(text: message),
      duration: const Duration(seconds: AppConstants.toastDurationInSeconds),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _titleCard() => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_cardRadius)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: _cardRadius)],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _topLineHeight,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(_cardRadius)),
                color: AppColors.cardTopLine,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(_largePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(AppConstants.appCompanyName, style: AppStyles.title28),
                  SizedBox(height: _smallPadding),
                  Text(AppConstants.appTitle, style: AppStyles.title28),
                  SizedBox(height: _largePadding),
                  Text(AppConstants.titleCardSubtitle, style: AppStyles.text14Black),
                ],
              ),
            ),
            const Divider(height: 1.0, color: Colors.grey),
            const Padding(
              padding: EdgeInsets.all(_largePadding),
              child: Text(AppConstants.titleCardInfo, style: AppStyles.text14Red),
            ),
          ],
        ),
      );

  Widget _languageCard(BuildContext context, QuestionnaireState state) => _questionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardTitle(text: AppConstants.languageCardTitle, isRequired: true),
            _languageTypeRadio(
              context,
              title: AppConstants.languageCardKotlin,
              itemValue: LanguageType.kotlin,
              groupValue: state.languageType,
            ),
            _languageTypeRadio(
              context,
              title: AppConstants.languageCardJava,
              itemValue: LanguageType.java,
              groupValue: state.languageType,
            ),
            _languageTypeRadio(
              context,
              title: AppConstants.languageCardCpp,
              itemValue: LanguageType.cpp,
              groupValue: state.languageType,
            ),
          ],
        ),
      );

  Widget _cardTitle({required String text, required bool isRequired}) => Row(
        children: [
          Text(text, style: AppStyles.title16),
          if (isRequired) const Text(AppConstants.cardTitleAsterisk, style: AppStyles.title16Red),
        ],
      );

  Widget _languageTypeRadio(
    BuildContext context, {
    required String title,
    required LanguageType itemValue,
    required LanguageType? groupValue,
  }) =>
      RadioListTile(
        title: Text(title, style: AppStyles.text14Black),
        value: itemValue,
        groupValue: groupValue,
        contentPadding: EdgeInsets.zero,
        onChanged: (value) {
          _cubit.languageChanged(value);
          FocusScope.of(context).unfocus();
        },
      );

  Widget _likeQuestionCard(QuestionnaireState state) => _questionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardTitle(text: AppConstants.likeQuestionCardTitle, isRequired: false),
            const SizedBox(height: _normalPadding),
            QuestionnaireTextField(
              controller: _likeQuestionController,
              originalText: state.likeQuestionAnswer,
              hintText: AppConstants.likeQuestionCardHint,
              isEnable: true,
              focusNode: _likeQuestionFocusNode,
            ),
          ],
        ),
      );

  Widget _homeAssignmentCard(BuildContext context, QuestionnaireState state) => _questionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardTitle(text: AppConstants.homeAssignmentCardTitle, isRequired: true),
            _difficultTypeRadio(
              context,
              title: AppConstants.homeAssignmentCardEasy,
              itemValue: DifficultType.easy,
              groupValue: state.homeAssignmentDifficultType,
            ),
            _difficultTypeRadio(
              context,
              title: AppConstants.homeAssignmentCardNormal,
              itemValue: DifficultType.normal,
              groupValue: state.homeAssignmentDifficultType,
            ),
            _difficultTypeRadio(
              context,
              title: AppConstants.homeAssignmentCardHard,
              itemValue: DifficultType.hard,
              groupValue: state.homeAssignmentDifficultType,
            ),
            _difficultTypeRadio(
              context,
              title: AppConstants.homeAssignmentCardOther,
              itemValue: DifficultType.other,
              groupValue: state.homeAssignmentDifficultType,
            ),
            QuestionnaireTextField(
              controller: _homeAssignmentController,
              originalText: state.homeAssignmentOther,
              isEnable: state.homeAssignmentOtherIsEnable,
              focusNode: _homeAssignmentFocusNode,
            ),
          ],
        ),
      );

  Widget _difficultTypeRadio(
    BuildContext context, {
    required String title,
    required DifficultType itemValue,
    required DifficultType? groupValue,
  }) =>
      RadioListTile(
        title: Text(title, style: AppStyles.text14Black),
        value: itemValue,
        groupValue: groupValue,
        contentPadding: EdgeInsets.zero,
        onChanged: (value) {
          _cubit.difficultyChanged(value);
          if (value == DifficultType.other) {
            FocusScope.of(context).requestFocus(_homeAssignmentFocusNode);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
      );

  Widget _submitButton(BuildContext context, QuestionnaireState state) => ElevatedButton(
        child: const Text(AppConstants.submitButtonText),
        onPressed: () {
          if (state.isButtonEnabled) {
            _cubit.submitButtonPressed();
            FocusScope.of(context).unfocus();
          } else {
            _showToast(context, AppConstants.buttonIsDisabledToast);
          }
        },
      );

  Widget _questionCard({required Widget child}) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_cardRadius)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: _cardRadius)],
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(_largePadding),
        child: child,
      );

  Widget _actionRow(BuildContext context, QuestionnaireState state) => Row(
        children: [
          _submitButton(context, state),
          const Spacer(),
          _settingsButton(context, state),
        ],
      );

  Widget _settingsButton(BuildContext context, QuestionnaireState state) => IconButton(
        // onPressed: () => _cubit.settingsButtonPressed(),
        onPressed: () => NetworkSettingsDialog(
          authorityController: _authorityController,
          portController: _portController,
          authorityValidator: _cubit.authorityValidator,
          portValidator: _cubit.portValidator,
          onApply: _cubit.onNetworkSettingsApply,
        )..show(context),
        icon: SvgPicture.asset(AppConstants.iconSettings),
      );
}
