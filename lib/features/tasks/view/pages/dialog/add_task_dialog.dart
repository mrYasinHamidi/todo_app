import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_toast.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:todo_app/features/tasks/view/viewModels/addTask/add_task_view_model.dart';
import 'package:todo_app/global/widgets/default_text_field.dart';
import 'package:todo_app/global/widgets/default_time_picker.dart';
import 'package:todo_app/global/widgets/item_button.dart';
import 'package:todo_app/injection.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final timeController = DefaultTimePickerController();
  final descriptionController = TextEditingController();
  final viewModel = getIt<AddTaskViewModel>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: _listener,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () => context.pop(), icon: Icon(Icons.close_rounded)),
                Text(
                  AppTranslate.task.getString(context),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Gap(70),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppTranslate.addTask.getString(context),
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    DefaultTextField(
                      controller: descriptionController,
                      validator:
                          (value) =>
                              value?.isNotEmpty == true ? null : AppTranslate.taskDescriptionError.getString(context),
                      counterText: ' ',
                      label: AppTranslate.taskDescription.getString(context),
                    ),
                    DefaultTimePicker(controller: timeController, label: AppTranslate.dueDateHint.getString(context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppTranslate.today.getString(context), style: TextStyle(fontSize: 16)),
                        BlocBuilder(
                          bloc: viewModel,
                          buildWhen: (_, state) => state is IsTodayState,
                          builder: (_, state) {
                            return Switch(value: viewModel.isToday, onChanged: (value) => viewModel.changeIsToday());
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    ItemButton(
                      onTap: _submit,
                      color: Colors.black,
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          AppTranslate.done.getString(context),
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                    Gap(8),
                    Text(
                      AppTranslate.addTaskBottomMessage.getString(context),
                      style: TextStyle(color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (formKey.currentState?.validate() == true) {
      viewModel.addTask(descriptionController.text, timeController.value);
    }
  }

  void _listener(BuildContext context, AddTaskState state) {
    if (state is AddTaskFail) {
      AppToast.show(state.errorMessage.getString(context), isError: true);
    }
    if (state is AddTaskSuccess) {
      context.pop(state.task);
      AppToast.show(AppTranslate.successMessage.getString(context));
    }
  }
}
