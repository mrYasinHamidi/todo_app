import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupViewModel extends Cubit<SignupState> {
  SignupViewModel() : super(const SignupInitialState());
}
