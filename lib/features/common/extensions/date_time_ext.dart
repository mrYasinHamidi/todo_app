import 'package:flutter/material.dart';

extension DateTimeExt on TimeOfDay {
  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
