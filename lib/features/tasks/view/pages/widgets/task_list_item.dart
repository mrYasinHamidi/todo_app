import 'package:flutter/material.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/global/widgets/default_check_box.dart';
import 'package:todo_app/global/widgets/item_button.dart';

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
                : Icon(Icons.circle, color: Colors.black, size: 12),
      ),
      title: Text(
        task.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: task.isCompleted ? Colors.black38 : Colors.black87,
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
                  color: Colors.black54,
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
    );
    return ItemButton(
      onTap: onTap,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child:
                task.isToday
                    ? Checkbox(value: task.isCompleted, onChanged: (value) => onCompleteTap())
                    : Icon(Icons.circle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.description,
                  style: TextStyle(
                    color: task.isCompleted ? Colors.black38 : Colors.black87,
                    fontWeight: FontWeight.w600,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (task.dueDate != null)
                  Text(
                    '${task.dueDate!.hour} : ${task.dueDate!.minute}',
                    style: TextStyle(
                      color: Colors.black54,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
