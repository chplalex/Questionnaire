class AppConstants {
  static const appTitle = "Questionnaire";
  static const appCompanyName = "GoTech";

  static const titleCardSubtitle = "Show me what you got!";
  static const titleCardInfo = "* Required";

  static const languageCardTitle = "What language is your favorite?";
  static const languageCardKotlin = "Kotlin";
  static const languageCardJava = "Java";
  static const languageCardCpp = "C++";

  static const likeQuestionCardTitle = "What do you like about programming?";
  static const likeQuestionCardHint = "Your answer";

  static const homeAssignmentCardTitle = "How was the assignment?";

  static const homeAssignmentCardEasy = "Easy";
  static const homeAssignmentCardNormal = "Normal";
  static const homeAssignmentCardHard = "Hard";
  static const homeAssignmentCardOther = "Other";

  static const submitButtonText = "Submit";

  static const apiMaxRequestAttempts = 3;
  static const apiRetryDelayFactorDuration = Duration(milliseconds: 1000);

  static var questionnaireAuthority = "localhost";
  static var questionnairePort = "3000";

  static const updateQuestionnaireEndPoint = "posts";

  static const toastDurationInSeconds = 2;

  static const buttonIsDisabledToast = "Please, fill all required fields";

  static const connectionTimeoutDuration = Duration(seconds: 2);

  static const cardTitleAsterisk = " *";

  static const successMessage = "Success";

  static const iconSettings = "assets/ic_settings.svg";

  static const networkSettingsDialogTitle = "Network Settings";
  static const networkSettingsDialogLabelAuthority = "Host authority";
  static const networkSettingsDialogLabelPort = "Port";

  static const buttonLabelApply = "Apply";
  static const buttonLabelCancel = "Cancel";

  static const authorityIsEmptyError = "can't be empty";

  static const portNotIntegerError = "should be empty or integer";
  static const portRangeError = "integer can be from 1025 to 65536";
}