part of 'tasks_view_model.dart';

sealed class TasksState {
  const TasksState();
}

class TasksInitialState extends TasksState {
  const TasksInitialState();
}

class TasksListState extends TasksState {
  final List<AppTask> tasks;

  TasksListState({required this.tasks});
}

class TasksEmptyState extends TasksState {}

class AllTasksDoneState extends TasksState {}

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
