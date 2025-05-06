import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error.dart';
import 'package:todo_app/core/repository/base_repository.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/features/tasks/data/services/tasks_local_service.dart';
import 'package:todo_app/features/tasks/task_mapper.dart';
import 'package:todo_app/models/app_user.dart';

class TaskRepository extends BaseRepository {
  final TasksLocalService _localService;
  final TaskMapper _mapper;

  TaskRepository({required TasksLocalService localService, required TaskMapper mapper})
    : _localService = localService,
      _mapper = mapper;

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

  Future<Either<Failure, void>> deleteTask(AppTask task) {
    return perform(() {
      return _localService.deleteTask(task);
    });
  }

  Either<Failure, AppUser?> getUser() => _mapper.getUser();
}
