import 'package:flutter/material.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/viewModels/app/app_view_model.dart';

sealed class AppTheme {
  static AppTheme get() => getIt<AppViewModel>().appTheme;

  abstract final Color primaryColor;
  final String? fontFamily = null;

  late final ThemeData themeData = ThemeData(primaryColor: primaryColor, fontFamily: fontFamily);
}

class DarkTheme extends AppTheme {
  @override
  Color get primaryColor => Colors.red;
}

class LightTheme extends AppTheme {
  @override
  Color get primaryColor => Colors.blue;
}
