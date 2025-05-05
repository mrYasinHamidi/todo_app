part of 'tasks_view_model.dart';

sealed class TasksState {
  const TasksState();
}

class TasksInitialState extends TasksState {
  const TasksInitialState();
}
