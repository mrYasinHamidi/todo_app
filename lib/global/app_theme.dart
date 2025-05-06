import 'package:flutter/material.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/viewModels/app/app_view_model.dart';

sealed class AppTheme {
  static AppTheme get() => getIt<AppViewModel>().appTheme;

  final String? fontFamily = null;

  abstract final ThemeData themeData;
}

class DarkTheme extends AppTheme {
  @override
  ThemeData get themeData => ThemeData.dark();
}

class LightTheme extends AppTheme {
  @override
  ThemeData get themeData => ThemeData.light();
}
