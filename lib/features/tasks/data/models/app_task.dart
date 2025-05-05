import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'app_task.g.dart';

@HiveType(typeId: 2)
class AppTask extends HiveObject with EquatableMixin{
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final bool isToday;

  @HiveField(3)
  final bool isCompleted;

  AppTask({required this.id, required this.description, required this.isToday, required this.isCompleted});

  factory AppTask.create({required String description, required bool isToday}) {
    return AppTask(
      id: DateTime.now().millisecondsSinceEpoch,
      description: description,
      isToday: isToday,
      isCompleted: false,
    );
  }

  AppTask copyWith({
    int? id,
    String? description,
    bool? isToday,
    bool? isCompleted,
  }) {
    return AppTask(
      id: id ?? this.id,
      description: description ?? this.description,
      isToday: isToday ?? this.isToday,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id];
}
