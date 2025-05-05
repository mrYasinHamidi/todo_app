import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static Future open(BuildContext context) => context.pushNamed(AppRouter.signup);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
