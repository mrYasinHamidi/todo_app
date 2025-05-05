import 'package:get_it/get_it.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository.dart';
import 'package:todo_app/features/auth/data/services/auth_local_service.dart';
import 'package:todo_app/features/auth/data/services/auth_remote_service.dart';
import 'package:todo_app/viewModels/app/app_view_model.dart';
import 'package:todo_app/viewModels/login/login_view_model.dart';
import 'package:todo_app/viewModels/signup/signup_view_model.dart';
import 'package:todo_app/viewModels/tasks/tasks_view_model.dart';

import 'features/auth/view/viewModels/splash/splash_view_model.dart';

final getIt = GetIt.instance;

class Injection {
  static Future<void> setup() async {
    //services
    getIt.registerLazySingleton(() => AuthRemoteService());
    getIt.registerLazySingleton(() => AuthLocalService());

    //repositories
    getIt.registerLazySingleton(() => AuthRepository(localService: getIt(), remoteService: getIt()));

    //view-models
    getIt.registerFactory(() => SplashViewModel(repository: getIt()));
    getIt.registerFactory(() => LoginViewModel());
    getIt.registerFactory(() => SignupViewModel());
    getIt.registerFactory(() => TasksViewModel());
    getIt.registerSingleton(AppViewModel());

    await getIt<AuthLocalService>().ensureInitialize();
  }
}
