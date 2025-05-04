import 'package:flutter/material.dart';

sealed class AppTheme {
  abstract final Color primaryColor;

  late final ThemeData themeData = ThemeData(primaryColor: primaryColor);
}

class DarkTheme extends AppTheme {
  @override
  Color get primaryColor => Colors.red;
}

class LightTheme extends AppTheme {
  @override
  Color get primaryColor => Colors.blue;
}
