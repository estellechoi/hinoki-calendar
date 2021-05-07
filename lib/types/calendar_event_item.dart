import 'package:flutter/material.dart';

class CalendarEventItem {
  final int id;
  final bool isDone;
  final bool isImportant;
  final int order;
  final String title;
  final String startAt;
  final String date;
  final Color color;
  final String type;

  CalendarEventItem(
      {required this.id,
      this.isDone = false,
      this.isImportant = false,
      required this.order,
      required this.title,
      required this.startAt,
      required this.date,
      required this.color,
      this.type = 'default'});

  // factory CalendarEventItem.fromJson(Map<String, dynamic> json) {
  //   return CalendarEventItem(
  //       measurementDay: json['measurement_day'],
  //       monthBodyWeights: json['month_body_weights'].map((item) {
  //         return MonthBodyWeight.fromJson(item);
  //       }).toList());
  // }
}
