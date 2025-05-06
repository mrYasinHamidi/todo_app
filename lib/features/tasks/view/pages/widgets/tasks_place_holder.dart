import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo_app/core/app_translate.dart';

class TasksPlaceHolder extends StatelessWidget {
  const TasksPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Image.asset('assets/do_it.png',fit:BoxFit.contain ,)),
        Expanded(
          child: Text(
            AppTranslate.taskPlaceHolderMessage.getString(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: Colors.black38,
            ),
          ),
        ),
      ],
    );
  }
}
