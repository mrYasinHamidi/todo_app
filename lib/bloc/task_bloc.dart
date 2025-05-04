import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final Box<Task> taskBox;

  TaskBloc(this.taskBox) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) {
      final tasks = taskBox.values.toList();
      emit(TaskLoaded(tasks));
    });

    on<AddTask>((event, emit) {
      taskBox.add(event.task);
      add(LoadTasks());
    });

    on<UpdateTask>((event, emit) {
      event.task.save();
      add(LoadTasks());
    });

    on<DeleteTask>((event, emit) {
      event.task.delete();
      add(LoadTasks());
    });
  }
}