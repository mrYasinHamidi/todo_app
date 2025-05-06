import 'package:get_it/get_it.dart';
import 'package:todo_app/features/auth/auth_mapper.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository.dart';
import 'package:todo_app/features/auth/data/services/auth_local_service.dart';
import 'package:todo_app/features/auth/data/services/auth_remote_service.dart';
import 'package:todo_app/features/tasks/data/repositories/tasks_repository.dart';
import 'package:todo_app/features/tasks/data/services/tasks_local_service.dart';
import 'package:todo_app/features/tasks/task_mapper.dart';
import 'package:todo_app/features/tasks/view/viewModels/addTask/add_task_view_model.dart';
import 'package:todo_app/features/common/viewModels/app/app_view_model.dart';
import '../features/auth/view/viewModels/login/login_view_model.dart';
import '../features/auth/view/viewModels/signup/signup_view_model.dart';
import '../features/auth/view/viewModels/splash/splash_view_model.dart';
import '../features/tasks/view/viewModels/tasks/tasks_view_model.dart';

final getIt = GetIt.instance;

class Injection {
  static Future<void> setup() async {
    //services
    getIt.registerLazySingleton(() => AuthRemoteService());
    getIt.registerLazySingleton(() => AuthLocalService());
    getIt.registerLazySingleton(() => TasksLocalService());

    //repositories
    getIt.registerLazySingleton(() => AuthRepository(localService: getIt(), remoteService: getIt()));
    getIt.registerLazySingleton(() => TaskRepository(localService: getIt(), mapper: getIt()));

    //view-models
    getIt.registerFactory(() => SplashViewModel(repository: getIt()));
    getIt.registerFactory(() => LoginViewModel(authRepository: getIt()));
    getIt.registerFactory(() => SignupViewModel(authRepository: getIt()));
    getIt.registerFactory(() => TasksViewModel(repository: getIt()));
    getIt.registerFactory(() => AddTaskViewModel(repository: getIt()));
    getIt.registerSingleton(AppViewModel());

    //mappers
    getIt.registerLazySingleton(() => AuthMapper(repository: getIt()));
    getIt.registerLazySingleton(() => TaskMapper(authMapper: getIt()));

    await getIt<AuthLocalService>().ensureInitialize();
    await getIt<TasksLocalService>().ensureInitialize();
  }
}
