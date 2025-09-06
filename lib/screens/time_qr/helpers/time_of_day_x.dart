import 'package:flutter/material.dart';

extension TimeOfDayX on TimeOfDay {
  int get inMinutes => hour * 60 + minute;

  bool isBetween(TimeOfDay from, TimeOfDay to) {
    final now = inMinutes;
    final start = from.inMinutes;
    final end = to.inMinutes;
    return now >= start && now <= end;
  }
}