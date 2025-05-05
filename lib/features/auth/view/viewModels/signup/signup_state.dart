part of 'signup_view_model.dart';

sealed class SignupState {
  const SignupState();
}

class SignupInitialState extends SignupState {
  const SignupInitialState();
}

class SignupLoadingState extends SignupState {}

class SignupFailState extends SignupState {
  final String errorMessage;

  SignupFailState({required this.errorMessage});
}

class SignupSuccessState extends SignupState {
  final AppUser appUser;

  SignupSuccessState({required this.appUser});
}
