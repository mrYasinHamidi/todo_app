part of 'splash_view_model.dart';

sealed class SplashState {
  const SplashState();
}

class SplashInitialState extends SplashState {
  const SplashInitialState();
}

class UserSignedState extends SplashState {}

class UserUnSignedState extends SplashState {}

class SplashErrorState extends SplashState {
  final String errorMessage;

  SplashErrorState({required this.errorMessage});
}
