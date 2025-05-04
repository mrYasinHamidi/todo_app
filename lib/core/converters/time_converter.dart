import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeConverter extends JsonConverter<TimeOfDay, String> {
  const TimeConverter();

  @override
  TimeOfDay fromJson(String json) {
    final hour = json.split(':').first;
    final minute = json.split(':').last;
    return TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
  }

  @override
  String toJson(TimeOfDay object) {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final String hourLabel = addLeadingZeroIfNeeded(object.hour);
    final String minuteLabel = addLeadingZeroIfNeeded(object.minute);

    return '$hourLabel:$minuteLabel';
  }
}
