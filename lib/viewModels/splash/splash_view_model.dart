import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashViewModel extends Cubit<SplashState> {
  SplashViewModel() : super(SplashInitialState());
  void checkLoginStatus(){

  }
}
