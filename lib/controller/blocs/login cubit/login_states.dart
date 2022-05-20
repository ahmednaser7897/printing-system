// ignore_for_file: camel_case_types

abstract class LoginStates {}

class InitLogin extends LoginStates {}

class LoadingRegistration extends LoginStates {}

class ScRegister extends LoginStates {}

class ErrorRegister extends LoginStates {
  final String error;
  ErrorRegister(this.error);
}

class CreateUserLoading extends LoginStates {}

class ScCreateUser extends LoginStates {
  final String uId;
  ScCreateUser(this.uId);
}

class CreateUserError extends LoginStates {
  final String error;
  CreateUserError(this.error);
}

class ChangePasswordVisibilityRegistration extends LoginStates {}

class ChangePasswordVisibility extends LoginStates {}

class LoadingLogin extends LoginStates {}

class ScLogin extends LoginStates {
  //final String uId;
  //ScLogin(this.uId);
}

class ErrorLogin extends LoginStates {
  final String error;
  ErrorLogin(this.error);
}

class createLogInDB extends LoginStates {}
