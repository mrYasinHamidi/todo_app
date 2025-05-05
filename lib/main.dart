import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/router.dart';
import 'package:todo_app/global/notification_service.dart';
import 'package:todo_app/viewModels/app/app_view_model.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'firebase_options.dart';

final localization = FlutterLocalization.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();
  await Injection.setup();
  await localization.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appViewModel = getIt<AppViewModel>();

  @override
  void initState() {
    appViewModel.initializeTranslation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppViewModel, AppState>(
      bloc: appViewModel,
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: appViewModel.appTheme.themeData,
          supportedLocales: localization.supportedLocales,
          localizationsDelegates: localization.localizationsDelegates,
        );
      },
    );
  }
}
