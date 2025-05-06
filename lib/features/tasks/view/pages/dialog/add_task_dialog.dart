import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_toast.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:todo_app/features/tasks/data/models/app_task.dart';
import 'package:todo_app/features/tasks/view/viewModels/addTask/add_task_view_model.dart';
import 'package:todo_app/features/common/app_theme.dart';
import 'package:todo_app/features/common/widgets/default_text_field.dart';
import 'package:todo_app/features/common/widgets/default_time_picker.dart';
import 'package:todo_app/features/common/widgets/item_button.dart';
import 'package:todo_app/core/injection.dart';

class AddTaskDialog extends StatefulWidget {
  final AppTask? task;

  const AddTaskDialog({super.key, this.task});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late final timeController = DefaultTimePickerController(
    date:
        widget.task?.dueDate == null
            ? null
            : TimeOfDay(hour: widget.task!.dueDate!.hour, minute: widget.task!.dueDate!.hour),
  );
  late final descriptionController = TextEditingController(text: widget.task?.description);
  final viewModel = getIt<AddTaskViewModel>();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.task?.isToday != viewModel.isToday) {
      viewModel.changeIsToday();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return BlocListener(
      bloc: viewModel,
      listener: _listener,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.task == null
                        ? AppTranslate.addTask.getString(context)
                        : AppTranslate.editTask.getString(context),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  DefaultTextField(
                    controller: descriptionController,
                    minLines: 1,
                    maxLines: 4,
                    validator:
                        (value) =>
                            value?.isNotEmpty == true ? null : AppTranslate.taskDescriptionError.getString(context),
                    counterText: ' ',
                    label: AppTranslate.taskDescription.getString(context),
                  ),
                  DefaultTimePicker(controller: timeController, label: AppTranslate.dueDateHint.getString(context)),
                  MaxGap(16),
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
                  if (bottomInsets == 0) ...[
                    MaxGap(32),
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
                    MaxGap(8),
                    Text(
                      AppTranslate.addTaskBottomMessage.getString(context),
                      style: TextStyle(
                        color: AppTheme.get().themeData.colorScheme.onSurface.withAlpha(100),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  MaxGap(bottomInsets),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (formKey.currentState?.validate() == true) {
      if (widget.task != null) {
        viewModel.editTask(
          description: descriptionController.text,
          timeOfDay: timeController.value,
          appTask: widget.task!,
        );
      } else {
        viewModel.addTask(description: descriptionController.text, timeOfDay: timeController.value);
      }
    }
  }

  void _listener(BuildContext context, AddTaskState state) {
    if (state is AddTaskFail) {
      AppToast.show(state.errorMessage.getString(context), isError: true);
    } else if (state is AddTaskSuccess) {
      viewModel.scheduleNotification(state.task);
      AppToast.show(AppTranslate.successMessage.getString(context));
      context.pop(state.task);
    }
  }
}
