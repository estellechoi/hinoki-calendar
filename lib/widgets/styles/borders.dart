import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;

// Border Styles
final Border none = Border.fromBorderSide(BorderSide.none);

final Border white =
    Border.all(width: 1.0, style: BorderStyle.solid, color: colors.white);

final Border lightgrey =
    Border.all(width: 1.0, style: BorderStyle.solid, color: colors.lightgrey);

final Border primaryDeco =
    Border.all(width: 1.0, style: BorderStyle.solid, color: colors.primaryDeco);

final Border calendarStrongCell = Border.all(
    width: 3.0, style: BorderStyle.solid, color: colors.calendarStrongCell);

// Border Dividers
final Border dividerTop = Border(
    top: BorderSide(
        width: 0.5, style: BorderStyle.solid, color: colors.divider));

final Border sectionDividerBottom = Border(
    top: BorderSide.none,
    bottom: BorderSide(
        width: 1.0, style: BorderStyle.solid, color: colors.sectionDivider));

// Radius
final BorderRadius radiusBase = BorderRadius.all(Radius.circular(12.0));
final BorderRadius radiusRound = BorderRadius.circular(20.0);
final BorderRadius radiusCircle = BorderRadius.circular(50.0);
final BorderRadius radiusNone = BorderRadius.all(Radius.circular(0.0));
final BorderRadius radiusLight = BorderRadius.all(Radius.circular(5.0));

// Calendar
final BorderRadius radiusCalendarRight =
    BorderRadius.horizontal(right: Radius.circular(50.0));
final BorderRadius radiusCalendarLeft =
    BorderRadius.horizontal(left: Radius.circular(50.0));
final BorderRadius radiusCalendarHorizontal =
    BorderRadius.all(Radius.circular(50.0));

// Bottom Sliding Modal
final BorderRadius radiusBottomModal = BorderRadius.only(
  topLeft: Radius.circular(15),
  topRight: Radius.circular(15),
);

final RoundedRectangleBorder modalShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0));

final RoundedRectangleBorder modalSubShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));
