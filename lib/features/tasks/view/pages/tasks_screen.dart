import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/features/tasks/view/pages/dialog/add_task_dialog.dart';
import 'package:todo_app/features/tasks/view/pages/widgets/task_list_item.dart';
import 'package:todo_app/features/tasks/view/viewModels/tasks/tasks_view_model.dart';
import 'package:todo_app/global/widgets/default_question_dialog.dart';
import 'package:todo_app/global/widgets/item_button.dart';
import 'package:todo_app/injection.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final viewModel = getIt<TasksViewModel>();

  @override
  void initState() {
    viewModel.loadUser();
    viewModel.fetchTasks();
    _requestPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: _listener,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: _addTask, child: Icon(Icons.add)),
        appBar: AppBar(
          leading: Icon(Icons.person_3_outlined),
          title: BlocBuilder(
            bloc: viewModel,
            buildWhen: (_, state) => state is TasksUserState,
            builder: (_, state) {
              return Text(viewModel.user?.email ?? AppTranslate.task.getString(context));
            },
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.login_outlined))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder(
            bloc: viewModel,
            buildWhen: (_, state) => state is TasksListState || state is TasksEmptyState,
            builder: (_, state) {
              return switch (state) {
                TasksListState() => ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppTranslate.today.getString(context),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),
                            ),
                            if (viewModel.todayTasks.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  ' ( ${viewModel.todayTasks.length} ${AppTranslate.task.getString(context)} )',
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
                                ),
                              ),
                          ],
                        ),
                        BlocBuilder(
                          bloc: viewModel,
                          buildWhen: (_, state) => state is TasksVisibilityState,
                          builder: (_, state) {
                            return ItemButton(
                              onTap: () => viewModel.toggleCompletedTasksVisibility(),
                              color: Colors.transparent,
                              child: Text(
                                viewModel.showCompleted
                                    ? AppTranslate.hideCompleted.getString(context)
                                    : AppTranslate.showCompleted.getString(context),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: viewModel.todayTasks.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlocBuilder(
                          buildWhen: (_, state) => state is TaskStatusState,
                          bloc: viewModel,
                          builder: (_, state) {
                            final task = viewModel.todayTasks[index];
                            return TaskListItem(
                              onDelete: () => _deleteTask(viewModel.todayTasks[index]),
                              task: task,
                              onCompleteTap: () => viewModel.changeTaskStatus(task),
                              onTap: () => _addTask(task: viewModel.todayTasks[index]),
                            );
                          },
                        );
                      },
                    ),
                    const Gap(16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppTranslate.tomorrow.getString(context),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),
                        ),
                        if (viewModel.tomorrowTasks.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              ' ( ${viewModel.tomorrowTasks.length} ${AppTranslate.task.getString(context)} )',
                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
                            ),
                          ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: viewModel.tomorrowTasks.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder:
                          (context, index) => TaskListItem(
                            task: viewModel.tomorrowTasks[index],
                            onCompleteTap: () {},
                            onDelete: () => _deleteTask(viewModel.tomorrowTasks[index]),
                            onTap: () => _addTask(task: viewModel.tomorrowTasks[index]),
                          ),
                    ),
                  ],
                ),
                TasksEmptyState() => Text(AppTranslate.task.getString(context)),
                _ => SizedBox(),
              };
            },
          ),
        ),
      ),
    );
  }

  void _addTask({AppTask? task}) async {
    await showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) => AddTaskDialog(task: task),
    );
    viewModel.fetchTasks();
  }

  void _requestPermissions() {
    [Permission.scheduleExactAlarm, Permission.notification].request();
  }

  void _listener(BuildContext context, TasksState state) {
    switch (state) {
      case TaskStatusState():
        viewModel.checkScheduledNotification(state.task);
        break;
      case TasksVisibilityState():
        viewModel.fetchTasks();
        break;
      case TaskDeletedState():
        viewModel.checkScheduledNotification(state.task, isDeleted: true);
        viewModel.fetchTasks();
        break;
      default:
        break;
    }
  }

  void _deleteTask(AppTask task) {
    DefaultQuestionDialog(
      title: AppTranslate.deleteTask.getString(context),
      desc: AppTranslate.deleteTaskMessage.getString(context),
    ).open(context).then((value) {
      if (value == true) {
        viewModel.deleteTask(task);
      }
    });
  }
}
