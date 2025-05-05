import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:todo_app/global/widgets/default_text_field.dart';
import 'package:todo_app/global/widgets/default_time_picker.dart';
import 'package:todo_app/global/widgets/item_button.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final timeController = DefaultTimePickerController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppTranslate.addTask.getString(context),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                DefaultTextField(label: AppTranslate.name.getString(context)),
                DefaultTimePicker(controller: timeController, label: AppTranslate.hour.getString(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppTranslate.today.getString(context), style: TextStyle(fontSize: 16)),
                    Switch(value: true, onChanged: (value) {}),
                  ],
                ),
                Spacer(),
                ItemButton(
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
      ],
    );
  }
}
