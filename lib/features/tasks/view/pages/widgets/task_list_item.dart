import 'package:flutter/material.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/features/common/app_theme.dart';
import 'package:todo_app/features/common/widgets/default_check_box.dart';

class TaskListItem extends StatelessWidget {
  final AppTask task;
  final VoidCallback onCompleteTap;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onCompleteTap,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: SizedBox(
        height: 30,
        width: 30,
        child:
            task.isToday
                ? DefaultCheckBox(value: task.isCompleted, onChanged: (value) => onCompleteTap())
                : Icon(Icons.circle, size: 12, color: AppTheme.get().themeData.colorScheme.onSurface),
      ),
      title: Text(
        task.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppTheme.get().themeData.colorScheme.onSurface.withAlpha(task.isCompleted ? 100 : 250),
          fontWeight: FontWeight.w600,
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 42,
            height: 42,
            child: IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete_outline_rounded),
              color: Colors.red,
              iconSize: 24,
            ),
          ),
          SizedBox(
            width: 42,
            height: 42,
            child: IconButton(onPressed: onTap, icon: Icon(Icons.more_vert_rounded), iconSize: 24),
          ),
        ],
      ),
      subtitle:
          task.dueDate == null
              ? null
              : Text(
                '${task.dueDate!.hour} : ${task.dueDate!.minute}',
                style: TextStyle(
                  color: AppTheme.get().themeData.colorScheme.onSurface.withAlpha(task.isCompleted ? 100 : 150),
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
    );
  }
}
