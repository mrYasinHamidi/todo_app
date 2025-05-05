import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'app_task.g.dart';

@HiveType(typeId: 2)
class AppTask extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final bool isToday;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final DateTime? dueDate;

  AppTask({
    required this.id,
    required this.description,
    required this.isToday,
    required this.isCompleted,
    this.dueDate,
  });

  factory AppTask.create({required String description, required bool isToday, DateTime? finishTime}) {
    return AppTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      description: description,
      dueDate: finishTime,
      isToday: isToday,
      isCompleted: false,
    );
  }

  @override
  List<Object?> get props => [id];

  AppTask copyWith({String? id, String? description, bool? isToday, bool? isCompleted, DateTime? finishTime}) {
    return AppTask(
      id: id ?? this.id,
      description: description ?? this.description,
      isToday: isToday ?? this.isToday,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: finishTime ?? this.dueDate,
    );
  }
}

extension TaskListX on List<AppTask> {
  (List<AppTask> today, List<AppTask> tomorrow) separateTasks() {
    final todayTasks = <AppTask>[];
    final tomorrowTasks = <AppTask>[];
    for (AppTask task in this) {
      if (task.isToday) {
        todayTasks.add(task);
      } else {
        tomorrowTasks.add(task);
      }
    }
    return (todayTasks, tomorrowTasks);
  }
}
