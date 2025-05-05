import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/features/tasks/data/repositories/tasks_repository.dart';

part 'tasks_state.dart';

class TasksViewModel extends Cubit<TasksState> {
  final TaskRepository _repository;

  TasksViewModel({required TaskRepository repository}) : _repository = repository, super(const TasksInitialState());

  bool _showCompleted = true;
  List<AppTask> _tasks = [];

  void fetchTasks() {
    final result = _repository.getTasks();
    result.fold((l) => emit(TasksErrorState(errorMessage: l.error)), (r) {
      _tasks = r;
      if (_tasks.isEmpty) {
        emit(TasksEmptyState());
      } else {
        if (_showCompleted) {
          emit(TasksListState(tasks: _tasks));
        } else {
          _tasks = _tasks.where((element) => !element.isCompleted).toList();
          if (_tasks.isEmpty) {
            emit(AllTasksDoneState());
          } else {
            emit(TasksListState(tasks: _tasks));
          }
        }
      }
    });
  }

  void changeTaskStatus(AppTask task) async {
    final result = await _repository.saveTask(task.copyWith(isCompleted: !task.isCompleted));
    result.fold((l) => emit(TasksErrorState(errorMessage: l.error)), (r) {
      emit(TaskStatusState(task: r));
    });
  }

  void toggleCompletedTasksVisibility() {
    _showCompleted = !_showCompleted;
    emit(TasksVisibilityState(showCompleted: _showCompleted));
  }
}
