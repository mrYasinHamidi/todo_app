import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:todo_app/global/app_theme.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo_app/main.dart';

part 'app_state.dart';

class AppViewModel extends Cubit<AppState> {
  AppViewModel() : super(AppInitialState());
  AppTheme appTheme = LightTheme();

  void initializeTranslation() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppTranslate.EN, countryCode: 'US'),
        const MapLocale('fa', AppTranslate.FA, countryCode: 'FA'),
      ],
      initLanguageCode: 'en',
    );

    FlutterLocalization.instance.onTranslatedLanguage = changeLanguage;
  }

  void changeLanguage(Locale? locale) {
    emit(AppLangState());
  }

  void changeTheme() {
    appTheme = switch (appTheme) {
      DarkTheme() => LightTheme(),
      LightTheme() => DarkTheme(),
    };
    emit(AppThemeState());
  }
}
