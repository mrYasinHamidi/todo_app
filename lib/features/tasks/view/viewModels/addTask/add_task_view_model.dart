import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/features/tasks/data/repositories/tasks_repository.dart';
import 'package:todo_app/global/extensions/date_time_ext.dart';
import 'package:todo_app/global/notification_service.dart';

part 'add_task_state.dart';

class AddTaskViewModel extends Cubit<AddTaskState> {
  final TaskRepository _repository;

  AddTaskViewModel({required TaskRepository repository}) : _repository = repository, super(AddTaskInitialState());

  bool isToday = true;

  void changeIsToday() {
    isToday = !isToday;
    emit(IsTodayState(isToday: isToday));
  }

  void addTask({required String description, TimeOfDay? timeOfDay}) async {
    final task = AppTask.create(description: description, isToday: isToday, dueDate: timeOfDay?.toDateTime());

    final result = await _repository.saveTask(task);

    result.fold((l) => emit(AddTaskFail(errorMessage: l.error)), (r) => emit(AddTaskSuccess(task: r)));
  }

  void editTask({required String description, required AppTask appTask, TimeOfDay? timeOfDay}) async {
    final task = appTask.copyWith(description: description, isToday: isToday, dueDate: () => timeOfDay?.toDateTime());
    final result = await _repository.saveTask(task);

    result.fold((l) => emit(AddTaskFail(errorMessage: l.error)), (r) => emit(AddTaskSuccess(task: r)));
  }

  void scheduleNotification(AppTask task) async {
    ///cancel if already registered a notification for this task
    await NotificationService.cancel(task);

    ///schedule new notification if due date provided
    if (task.isToday && !task.isCompleted) {
      await NotificationService.scheduleNotification(task);
    }
  }
}
