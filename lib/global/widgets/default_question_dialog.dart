import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:todo_app/global/app_theme.dart';

import 'item_button.dart';

class DefaultQuestionDialog extends StatelessWidget {
  final String title;
  final String desc;
  final String? yesTitle;
  final String? noTitle;

  const DefaultQuestionDialog({super.key, required this.title, required this.desc, this.noTitle, this.yesTitle});

  Future<bool?> open(BuildContext context) {
    return showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(desc),
      actions: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 70),
          child: ItemButton(
            padding: const EdgeInsets.symmetric(vertical: 8),
            side: BorderSide(color: AppTheme.get().themeData.primaryColor),
            onTap: () => context.pop(true),
            child: Text(yesTitle ?? AppTranslate.yes.getString(context), textAlign: TextAlign.center),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 70),
          child: ItemButton(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: AppTheme.get().themeData.primaryColor,
            onTap: () => context.pop(false),
            splashColor: Colors.white,
            child: Text(
              noTitle ?? AppTranslate.no.getString(context),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
