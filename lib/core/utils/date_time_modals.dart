import 'package:flutter/material.dart';

Future<DateTime> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null) {
    return picked;
  }
  return DateTime.now();
}

Future<TimeOfDay> selectTime(BuildContext context) async {
  final TimeOfDay? picked =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (picked != null) {
    return picked;
  }
  return TimeOfDay.now();
}
