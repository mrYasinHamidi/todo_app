import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';

class TasksLocalService {
  late final Box _box;
  bool _initialized = false;

  Future<void> ensureInitialize() async {
    if (_initialized) return;
    _box = await Hive.openBox('tasksBox');
    _initialized = true;
  }

  Future<void> saveTask(AppTask task) async {
    await _box.put(task.id, task);
  }

  List<AppTask> getTasks() {
    return _box.values.toList().cast();
  }

  Future<void> deleteTask(AppTask task) {
    return _box.delete(task.key);
  }

  Future<void> clear() => _box.clear();
}
