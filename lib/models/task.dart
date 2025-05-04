
import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  DateTime endDate;

  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.endDate,
  });
}