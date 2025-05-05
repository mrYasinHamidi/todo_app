import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/router.dart';
import 'package:todo_app/viewModels/login/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Future<void> open(BuildContext context) => context.pushNamed(AppRouter.login);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(create: (context) => getIt.get(), child: _LoginScreen());
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
