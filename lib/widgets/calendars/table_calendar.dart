import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../styles/textstyles.dart' as textstyles;
import '../styles/borders.dart' as borders;
import '../styles/colors.dart' as colors;

class MyTableCalendar extends StatefulWidget {
  @override
  _MyTableCalendarState createState() => _MyTableCalendarState();
}

class _MyTableCalendarState extends State<MyTableCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      calendarBuilders: getCalendarBuilder(),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }

  CalendarBuilders getCalendarBuilder() {
    return CalendarBuilders(
      selectedBuilder: (context, date, events) => Align(
        alignment: Alignment.center,
        child: Container(
            width: 32.0,
            height: 32.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: colors.lightgrey, borderRadius: borders.radiusCircle),
            child:
                Text(date.day.toString(), style: textstyles.calendarTodayText)),
      ),
      todayBuilder: (context, date, events) => Align(
          alignment: Alignment.center,
          child: Container(
              width: 32.0,
              height: 32.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: colors.lightgrey, borderRadius: borders.radiusCircle),
              child: Text(date.day.toString(),
                  style: textstyles.calendarTodayText))),
    );
  }
}
