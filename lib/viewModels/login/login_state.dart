part of 'login_view_model.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitialStateState extends LoginState {
  const LoginInitialStateState();
}
