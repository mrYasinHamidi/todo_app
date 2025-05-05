// import 'package:chi_bepoosham/app.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
//
// import 'default_text_field.dart';
//
// typedef DefaultDatePickerValidator = String? Function(Jalali? value);
//
// class DefaultDatePicker extends StatefulWidget {
//   final Function(Jalali value)? onChange;
//   final DefaultDatePickerController? controller;
//   final DefaultDatePickerValidator? validator;
//   final String? label;
//   final String? counterText;
//
//   const DefaultDatePicker({
//     super.key,
//     this.onChange,
//     this.controller,
//     this.label,
//     this.validator,
//     this.counterText,
//   });
//
//   @override
//   State<DefaultDatePicker> createState() => _DefaultDatePickerState();
// }
//
// class _DefaultDatePickerState extends State<DefaultDatePicker> {
//   final _textController = TextEditingController();
//
//   @override
//   void initState() {
//     widget.controller?.addListener(() {
//       _textController.text = widget.controller?.value?.formatFullDate() ?? '';
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTextField(
//       label: widget.label,
//       readOnly: true,
//       counterText: widget.counterText,
//       controller: _textController,
//       onTap: () => _onTap(context),
//       validator: (value) => widget.validator?.call(widget.controller?.value),
//     );
//   }
//
//   void _onTap(BuildContext context) async {
//     Jalali? picked = await showPersianDatePicker(
//       context: context,
//       initialDate: Jalali.now(),
//       firstDate: Jalali(1385, 8),
//       lastDate: Jalali(1450, 9),
//       cancelText: 'cancel'.tr,
//       confirmText: 'submit'.tr,barrierLabel: 'l',
//       initialEntryMode:
//       PersianDatePickerEntryMode.calendarOnly,
//     );
//     if (picked != null) {
//       widget.onChange?.call(picked);
//       widget.controller?.value = picked;
//     }
//   }
// }
//
// class DefaultDatePickerController extends ValueNotifier<Jalali?> {
//   DefaultDatePickerController({Jalali? date}) : super(date);
//
//   factory DefaultDatePickerController.fromDateTime(DateTime? dateTime) {
//     return DefaultDatePickerController(date: dateTime == null ? null : Jalali.fromDateTime(dateTime));
//   }
// }
