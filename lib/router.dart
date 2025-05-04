import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/signup_screen.dart';
import 'package:todo_app/screens/splash_screen.dart';
import 'package:todo_app/screens/tasks_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: login,
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            },
          ),
          GoRoute(
            path: signup,
            builder: (BuildContext context, GoRouterState state) {
              return const SignupScreen();
            },
          ),
          GoRoute(
            path: tasks,
            builder: (BuildContext context, GoRouterState state) {
              return const TasksScreen();
            },
          ),
        ],
      ),
    ],
  );

  static final String login = 'login';
  static final String signup = 'signup';
  static final String tasks = 'tasks';
}
