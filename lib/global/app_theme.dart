import 'package:flutter/material.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/viewModels/app/app_view_model.dart';

sealed class AppTheme {
  static AppTheme get() => getIt<AppViewModel>().appTheme;

  abstract final Color primaryColor;
  final String? fontFamily = null;

  abstract final ThemeData themeData;
}

class DarkTheme extends AppTheme {
  @override
  Color get primaryColor => Colors.red;

  @override
  ThemeData get themeData => ThemeData.light().copyWith(primaryColor: primaryColor);
}

class LightTheme extends AppTheme {
  @override
  Color get primaryColor => Colors.blue;

  @override
  ThemeData get themeData => ThemeData.dark().copyWith(primaryColor: primaryColor);
}
