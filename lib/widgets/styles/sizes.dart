import 'package:flutter/material.dart';

final double emojiBox = 48.0;

final double appBar = 56;
final double bottomNavigationBar = 82;

double getBodyHeight(BuildContext context) {
  return MediaQuery.of(context).size.height - appBar - bottomNavigationBar;
}

// Chart
final lineChartDot = 4.0;
final lineChartDotStrokeWidth = 2.0;
final lineChartDotLineStrokeWidth = 2.0;

// Calendar
final calendarMarkerCommentIcon = 16.0;
final calendarMarker = 32.0;
