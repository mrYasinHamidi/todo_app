import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/app_theme.dart';

part 'app_state.dart';

class AppViewModel extends Cubit<AppState> {
  AppViewModel() : super(AppInitialState());
  AppTheme appTheme = LightTheme();

  void changeTheme() {
    appTheme = switch (appTheme) {
      DarkTheme() => LightTheme(),
      LightTheme() => DarkTheme(),
    };
    emit(AppThemeState());
  }
}
