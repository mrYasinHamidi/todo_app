import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository.dart';

part 'splash_state.dart';

class SplashViewModel extends Cubit<SplashState> {
  final AuthRepository _repository;

  SplashViewModel({required AuthRepository repository}) : _repository = repository, super(const SplashInitialState());

  void checkLoginStatus() async {
    final result = await _repository.isLoggedIn();
    result.fold((failure) => emit(SplashErrorState(errorMessage: failure.error)), (isLoggedIn) {
      if (isLoggedIn) {
        emit(UserSignedState());
      } else {
        emit(UserUnSignedState());
      }
    });
  }
}
