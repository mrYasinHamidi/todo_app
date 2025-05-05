import 'package:get_it/get_it.dart';
import 'package:todo_app/viewModels/app/app_view_model.dart';
import 'package:todo_app/viewModels/login/login_view_model.dart';
import 'package:todo_app/viewModels/signup/signup_view_model.dart';
import 'package:todo_app/viewModels/tasks/tasks_view_model.dart';

import 'features/auth/view/viewModels/splash/splash_view_model.dart';

final getIt = GetIt.instance;

class Injection {
  static void setup() {
    //view-models
    getIt.registerFactory(() => SplashViewModel());
    getIt.registerFactory(() => LoginViewModel());
    getIt.registerFactory(() => SignupViewModel());
    getIt.registerFactory(() => TasksViewModel());
    getIt.registerSingleton(AppViewModel());
  }
}
