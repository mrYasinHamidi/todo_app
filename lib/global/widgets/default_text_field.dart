import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatelessWidget {
  final String? label;
  final VoidCallback? onTap;
  final bool enable;
  final bool readOnly;
  final TextInputType? inputType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String? counterText;
  final Widget? suffixIcon;
  final bool justInteger;
  final bool justFloat;
  final TextDirection? textDirection;
  final InputBorder? inputBorder;
  final bool? isCollapsed;
  final bool? isDense;

  const DefaultTextField({
    super.key,
    this.label,
    this.justInteger = false,
    this.justFloat = false,
    this.suffixIcon,
    this.controller,
    this.counterText,
    this.readOnly = false,
    this.enable = true,
    this.inputType,
    this.onTap,
    this.validator,
    this.textDirection,
    this.inputBorder,
    this.isDense,
    this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        counterText: counterText,
        suffixIcon: suffixIcon,
        border: inputBorder,
        errorBorder: inputBorder,
        focusedBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        isDense: isDense,
        isCollapsed: isCollapsed,
      ),
      controller: controller,
      enabled: enable,
      textDirection: textDirection,
      inputFormatters: <TextInputFormatter>[
        if (justInteger) FilteringTextInputFormatter.digitsOnly,
        if (justFloat) FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
      ],
      readOnly: readOnly,
      // keyboardType: inputType,
      validator: validator,
      onTap: onTap,
    );
  }
}
