import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/features/tasks/data/repositories/tasks_repository.dart';

part 'tasks_state.dart';

class TasksViewModel extends Cubit<TasksState> {
  final TaskRepository _repository;

  TasksViewModel({required TaskRepository repository}) : _repository = repository, super(const TasksInitialState());

  bool showCompleted = true;
  List<AppTask> todayTasks = [];
  List<AppTask> tomorrowTasks = [];

  void fetchTasks() {
    final result = _repository.getTasks();
    result.fold((l) => emit(TasksErrorState(errorMessage: l.error)), (tasks) {
      if (tasks.isEmpty) {
        emit(TasksEmptyState());
      } else {
        if (showCompleted) {
          final separatedByDay = tasks.separateTasks();
          todayTasks = separatedByDay.$1;
          tomorrowTasks = separatedByDay.$2;
          emit(TasksListState(today: todayTasks, tomorrow: tomorrowTasks));
        } else {
          final notCompleted = tasks.where((element) => !element.isCompleted).toList();
          if (notCompleted.isEmpty) {
            emit(AllTasksDoneState());
          } else {
            final separatedByDay = notCompleted.separateTasks();
            todayTasks = separatedByDay.$1;
            tomorrowTasks = separatedByDay.$2;
            emit(TasksListState(today: todayTasks, tomorrow: tomorrowTasks));
          }
        }
      }
    });
  }

  void changeTaskStatus(AppTask task) async {
    final result = await _repository.saveTask(task.copyWith(isCompleted: !task.isCompleted));
    result.fold((l) => emit(TasksErrorState(errorMessage: l.error)), (r) {
      final index = todayTasks.indexOf(task);
      if (index != -1) {
        todayTasks.removeAt(index);
        todayTasks.insert(index, r);
        emit(TaskStatusState(task: r));
      }
    });
  }

  void toggleCompletedTasksVisibility() {
    showCompleted = !showCompleted;
    emit(TasksVisibilityState(showCompleted: showCompleted));
    fetchTasks();
  }
}
