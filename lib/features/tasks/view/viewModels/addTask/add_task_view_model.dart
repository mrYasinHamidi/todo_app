import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/features/tasks/data/repositories/tasks_repository.dart';
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

  void addTask(String name, TimeOfDay? finishTime, {AppTask? appTask}) async {
    DateTime? dueDate;
    if (finishTime != null) {
      final now = DateTime.now();
      dueDate = DateTime(now.year, now.month, now.day, finishTime.hour, finishTime.minute);
    }
    final task =
        appTask != null
            ? appTask.copyWith(description: name, isToday: isToday, dueDate: () => dueDate)
            : AppTask.create(description: name, isToday: isToday, finishTime: dueDate);
    final result = await _repository.saveTask(task);
    result.fold((l) => emit(AddTaskFail(errorMessage: l.error)), (r) {
      if (dueDate != null) {
        NotificationService.scheduleNotification(
          id: int.parse(task.id.replaceRange(0, 6, '')),
          title: 'Time to done your task!!!',
          body: task.description,
          scheduledDate: dueDate,
        );
      }
      emit(AddTaskSuccess(task: r));
    });
  }
}
