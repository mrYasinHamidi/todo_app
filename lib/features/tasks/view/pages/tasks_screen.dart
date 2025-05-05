import 'package:flutter/material.dart';
import 'package:todo_app/features/tasks/view/pages/dialog/add_task_dialog.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: _addTask));
  }

  void _addTask() {
    showModalBottomSheet(context: context, builder: (context) => AddTaskDialog());
  }
}
