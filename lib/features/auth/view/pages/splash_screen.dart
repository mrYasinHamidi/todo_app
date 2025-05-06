import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo_app/features/auth/view/viewModels/splash/splash_view_model.dart';
import 'package:todo_app/global/widgets/default_loading.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final viewModel = getIt<SplashViewModel>();

  @override
  void initState() {
    viewModel.checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: _listener,
      child: Scaffold(
        appBar: AppBar(title: Text(AppTranslate.showCompleted.getString(context))),
        body: BlocBuilder(
          bloc: viewModel,
          builder: (context, state) {
            return switch (state) {
              SplashErrorState() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage),
                  IconButton(onPressed: viewModel.checkLoginStatus, icon: Icon(Icons.refresh)),
                ],
              ),
              _ => Center(child: DefaultLoading()),
            };
          },
        ),
      ),
    );
  }

  void _listener(BuildContext context, state) {
    switch (state) {
      case UserSignedState():
        //navigate to Tasks page
        context.pushReplacementNamed(AppRouter.tasks);
        break;
      case UserUnSignedState():
        //navigate to Login page
        context.pushReplacementNamed(AppRouter.login);
        break;
      case SplashErrorState():
        // show error and let user try again
        break;
    }
  }
}
