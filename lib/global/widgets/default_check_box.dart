import 'package:flutter/material.dart';
import 'package:todo_app/global/app_theme.dart';

class DefaultCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;

  const DefaultCheckBox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.get().themeData.colorScheme.onSurface,
      side: BorderSide(width: 2, color: AppTheme.get().themeData.colorScheme.onSurface.withAlpha(100)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
