import 'package:flutter/material.dart';
import 'package:todo_app/core/app_translate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo_app/injection.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/viewModels/app/app_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTranslate.title.getString(context))),
      body: Column(children: [ElevatedButton(onPressed: () {}, child: Text('data'))]),
    );
  }
}
