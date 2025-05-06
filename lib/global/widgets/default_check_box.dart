import 'package:flutter/material.dart';

class DefaultCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;

  const DefaultCheckBox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: value == true ? Colors.black : Colors.white,
      side: BorderSide(width: 2, color: Colors.black12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
