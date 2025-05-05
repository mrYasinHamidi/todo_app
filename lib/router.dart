import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/auth/view/pages/login_screen.dart';
import 'package:todo_app/features/auth/view/pages/signup_screen.dart';
import 'package:todo_app/features/auth/view/pages/splash_screen.dart';
import 'package:todo_app/screens/tasks_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (BuildContext context, GoRouterState state) => SplashScreen()),
      GoRoute(path: login, name: login, builder: (context, state) => LoginScreen()),
      GoRoute(path: signup, name: signup, builder: (context, state) => SignupScreen()),
      GoRoute(path: tasks, name: tasks, builder: (context, state) => TasksScreen()),
    ],
  );

  static final String login = '/login';
  static final String signup = '/signup';
  static final String tasks = '/tasks';
}
