import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/common/app_theme.dart';

typedef DefaultDropDownItemBuilder<T> = Widget Function(T);

class DefaultDropDown<T> extends StatefulWidget {
  final List<T> values;
  final DefaultDropDownItemBuilder<T> itemBuilder;
  final T? defaultValue;
  final Widget? hint;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final FormFieldValidator<T>? validator;
  final FormFieldSetter<T>? onSaved;
  final Function(T?)? onChange;
  final Widget? icon;
  final BorderRadius borderRadius;
  final BorderSide buttonSide;
  final BorderSide? dropdownSide;
  final Color buttonColor;
  final Color dropdownColor;
  final List<BoxShadow> shadow;
  final EdgeInsets buttonPadding;
  final EdgeInsets itemPadding;
  final EdgeInsets dropdownPadding;
  final String? counterText;
  final TextStyle? errorStyle;
  final String? errorText;

  DefaultDropDown({
    super.key,
    required this.values,
    required this.itemBuilder,
    this.hint,
    this.defaultValue,
    this.validator,
    this.onSaved,
    this.onChange,
    this.icon,
    this.counterText,
    this.errorStyle,
    this.errorText,
    this.textStyle,
    this.hintStyle,
    this.buttonSide = const BorderSide(),
    this.dropdownSide,
    this.buttonColor = Colors.transparent,
    this.dropdownColor = Colors.white,
    this.shadow = const [],
    this.buttonPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.dropdownPadding = EdgeInsets.zero,
  }) : borderRadius = BorderRadius.circular(10);

  @override
  State<DefaultDropDown> createState() => _DefaultDropDownState<T>();
}

class _DefaultDropDownState<T> extends State<DefaultDropDown<T>> {
  T? current;

  @override
  void initState() {
    current = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items =
        widget.values
            .map(
              (e) => DropdownMenuItem<T>(
                value: e,
                child: DefaultTextStyle(
                  style:
                      AppTheme.get().themeData.textTheme.bodyMedium
                          ?.merge(widget.textStyle)
                          .copyWith(fontFamily: AppTheme.get().fontFamily, color: Colors.black) ??
                      const TextStyle(),
                  child: widget.itemBuilder(e),
                ),
              ),
            )
            .toList();

    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<T>(
        items: items,
        value: current,
        onChanged: (value) {
          setState(() {
            current = value;
          });
          widget.onChange?.call(value);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: widget.buttonSide, borderRadius: widget.borderRadius),
          fillColor: widget.buttonColor,
          errorText: widget.errorText,
          errorStyle: widget.errorStyle,
          counterText: widget.counterText,
          filled: true,
          contentPadding: EdgeInsets.zero,
        ),
        hint: DefaultTextStyle(
          style:
              AppTheme.get().themeData.textTheme.bodyMedium
                  ?.merge(widget.textStyle)
                  .copyWith(fontFamily: AppTheme.get().fontFamily) ??
              const TextStyle(),
          child: widget.hint ?? const SizedBox(),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(widget.dropdownSide ?? BorderSide(color: AppTheme.get().themeData.primaryColor)),
            borderRadius: widget.borderRadius,
            boxShadow: widget.shadow,
            color: widget.dropdownColor,
          ),
          padding: EdgeInsets.zero,
          isOverButton: true,
        ),
        buttonStyleData: ButtonStyleData(height: 58, padding: EdgeInsetsDirectional.only(end: 12, start: 8), width: 0),
        // buttonHeight: 48,
        // buttonWidth: 0,
        // dropdownOverButton: true,
        // buttonPadding: widget.buttonPadding,
        // itemPadding: widget.itemPadding,
        onSaved: widget.onSaved,
        validator: widget.validator,
        // dropdownPadding: widget.dropdownPadding,
        // icon: widget.icon ?? SvgPicture.asset('assets/images/arrow_down.svg'),
      ),
    );
  }
}
