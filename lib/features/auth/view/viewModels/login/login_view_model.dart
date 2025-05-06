import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository.dart';
import 'package:todo_app/features/common/models/app_user.dart';

part 'login_state.dart';

class LoginViewModel extends Cubit<LoginState> {
  final AuthRepository _repository;

  LoginViewModel({required AuthRepository authRepository})
    : _repository = authRepository,
      super(const LoginInitialStateState());

  void signIn(String email, String password) async {
    emit(LoginLoadingState());

    final result = await _repository.signIn(email, password);

    result.fold((failure) => emit(LoginFailState(errorMessage: failure.error)), (r) {
      emit(LoginSuccessState(appUser: r));
    });
  }
}
