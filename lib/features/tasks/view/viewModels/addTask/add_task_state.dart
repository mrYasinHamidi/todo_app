part of 'add_task_view_model.dart';

sealed class AddTaskState {}

class AddTaskInitialState extends AddTaskState {}

class IsTodayState extends AddTaskState {
  final bool isToday;

  IsTodayState({required this.isToday});
}

class AddTaskSuccess extends AddTaskState {
  final AppTask task;

  AddTaskSuccess({required this.task});
}

class AddTaskFail extends AddTaskState {
  final String errorMessage;

  AddTaskFail({required this.errorMessage});
}
