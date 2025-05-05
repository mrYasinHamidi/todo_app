import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository.dart';
import 'package:todo_app/models/app_user.dart';

part 'signup_state.dart';

class SignupViewModel extends Cubit<SignupState> {
  final AuthRepository _repository;

  SignupViewModel({required AuthRepository authRepository})
    : _repository = authRepository,
      super(const SignupInitialState());

  void signup(String email, String password) async {
    emit(SignupLoadingState());

    final result = await _repository.signup(email, password);

    result.fold((failure) => emit(SignupFailState(errorMessage: failure.error)), (r) {
      emit(SignupSuccessState(appUser: r));
    });
  }
}
