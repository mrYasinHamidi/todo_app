part of 'app_view_model.dart';

sealed class AppState {}

class AppInitialState extends AppState {}

class AppThemeState extends AppState {}

class AppLangState extends AppState {}

class LogoutState extends AppState {}
