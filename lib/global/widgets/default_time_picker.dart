import 'package:flutter/material.dart';

import 'default_text_field.dart';

typedef DefaultTimePickerValidator = String? Function(TimeOfDay? value);

class DefaultTimePicker extends StatefulWidget {
  final Function(TimeOfDay value)? onChange;
  final DefaultTimePickerController? controller;
  final DefaultTimePickerValidator? validator;
  final String? label;
  final String? counterText;
  final Widget? suffixIcon;

  const DefaultTimePicker({
    super.key,
    this.onChange,
    this.suffixIcon,
    this.controller,
    this.counterText,
    this.label,
    this.validator,
  });

  @override
  State<DefaultTimePicker> createState() => _DefaultTimePickerState();
}

class _DefaultTimePickerState extends State<DefaultTimePicker> {
  final _textController = TextEditingController();

  @override
  void initState() {
    widget.controller?.addListener(() {
      _textController.text = widget.controller?.value?.format(context) ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      label: widget.label,
      readOnly: true,
      suffixIcon: widget.suffixIcon,
      counterText: widget.counterText,
      controller: _textController,
      onTap: () => _onTap(context),
      validator: (value) => widget.validator?.call(widget.controller?.value),
    );
  }

  void _onTap(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      widget.onChange?.call(picked);
      widget.controller?.value = picked;
    }
  }
}

class DefaultTimePickerController extends ValueNotifier<TimeOfDay?> {
  DefaultTimePickerController({TimeOfDay? date}) : super(date);
}
