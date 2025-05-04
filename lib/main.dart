import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/app_theme.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/router.dart';
import 'package:todo_app/services/notification_service.dart';
import 'package:todo_app/viewModels/app/app_view_model.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();
  Injection.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appViewModel = getIt<AppViewModel>();

    return BlocBuilder<AppViewModel, AppState>(
      bloc: appViewModel,
      builder: (context, state) {
        return MaterialApp.router(routerConfig: AppRouter.router, theme: appViewModel.appTheme.themeData);
      },
    );
  }
}
