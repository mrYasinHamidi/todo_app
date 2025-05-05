import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error.dart';
import 'package:todo_app/core/repository/base_repository.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/features/tasks/data/services/tasks_local_service.dart';

class TaskRepository extends BaseRepository {
  final TasksLocalService _localService;

  TaskRepository({required TasksLocalService localService}) : _localService = localService;

  Future<Either<Failure, AppTask>> saveTask(AppTask task) {
    return perform(() async {
      await _localService.saveTask(task);
      return task;
    });
  }

  Either<Failure, List<AppTask>> getTasks() {
    return performSync(() {
      return _localService.getTasks();
    });
  }
}
