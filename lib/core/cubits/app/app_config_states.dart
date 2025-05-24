
abstract class AppConfigStates {}

class AppConfigInitial extends AppConfigStates {}

class AppConfigLoading extends AppConfigStates {}

class AppConfigSuccess extends AppConfigStates {
  AppConfigSuccess();
}

class AppConfigFailure extends AppConfigStates {
  final String error;
  AppConfigFailure(this.error);
}



class AppConfigUpdateCalculationLoading extends AppConfigStates {}

class AppConfigUpdateCalculationSuccess extends AppConfigStates {}

class AppConfigUpdateCalculationFailure extends AppConfigStates {
  final String message;
  AppConfigUpdateCalculationFailure(this.message);
}

