part of 'tasks_view_model.dart';

sealed class TasksState {
  const TasksState();
}

class TasksInitialState extends TasksState {
  const TasksInitialState();
}

class TasksListState extends TasksState {
  final List<AppTask> today;
  final List<AppTask> tomorrow;

  TasksListState({required this.tomorrow, required this.today});
}

class TasksEmptyState extends TasksState {}

class TasksErrorState extends TasksState {
  final String errorMessage;

  TasksErrorState({required this.errorMessage});
}

class TasksVisibilityState extends TasksState {
  final bool showCompleted;

  TasksVisibilityState({required this.showCompleted});
}

class TaskStatusState extends TasksState {
  final AppTask task;

  TaskStatusState({required this.task});
}

class TaskDeletedState extends TasksState {
  final AppTask task;

  TaskDeletedState({required this.task});
}
