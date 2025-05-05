part of 'login_view_model.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitialStateState extends LoginState {
  const LoginInitialStateState();
}

class LoginSuccessState extends LoginState {
  final AppUser appUser;

  LoginSuccessState({required this.appUser});
}

class LoginLoadingState extends LoginState {}

class LoginFailState extends LoginState {
  final String errorMessage;

  LoginFailState({required this.errorMessage});
}
