import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:todo_app/features/tasks/view/pages/dialog/add_task_dialog.dart';
import 'package:todo_app/features/tasks/view/pages/widgets/task_list_item.dart';
import 'package:todo_app/features/tasks/view/viewModels/tasks/tasks_view_model.dart';
import 'package:todo_app/global/notification_service.dart';
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
    viewModel.fetchTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _addTask),
      appBar: AppBar(
        leading: Icon(Icons.person_3_outlined),
        title: Column(children: [Text('yasin@gmail.com')]),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder(
          bloc: viewModel,
          buildWhen: (_, state) => state is TasksListState,
          builder: (_, state) {
            return switch (state) {
              TasksListState() => ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppTranslate.today.getString(context),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),
                      ),
                      BlocBuilder(
                        bloc: viewModel,
                        buildWhen: (_, state) => state is TasksVisibilityState,
                        builder: (_, state) {
                          return ItemButton(
                            onTap: () => viewModel.toggleCompletedTasksVisibility(),
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
                            task: task,
                            onCompleteTap: () => viewModel.changeTaskStatus(task),
                            onTap: () {},
                          );
                        },
                      );
                    },
                  ),
                  const Gap(16),
                  Text(
                    AppTranslate.tomorrow.getString(context),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),
                  ),
                  ListView.builder(
                    itemCount: state.tomorrow.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder:
                        (context, index) =>
                            TaskListItem(task: state.tomorrow[index], onCompleteTap: () {}, onTap: () {}),
                  ),
                ],
              ),
              _ => SizedBox(),
            };
          },
        ),
      ),
    );
  }

  void _addTask() async {
    await showModalBottomSheet(context: context, builder: (context) => AddTaskDialog());
    viewModel.fetchTasks();
  }
}
