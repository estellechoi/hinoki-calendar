import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../styles/borders.dart' as borders;
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../../utils/format.dart' as format;

class DatePickerCalendar extends StatefulWidget {
  final String defaultDate;
  final onPageChanged;
  final onDaySelected;

  DatePickerCalendar({
    Key? key,
    required this.defaultDate,
    required this.onPageChanged,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  _DatePickerCalendarState createState() => _DatePickerCalendarState();
}

class _DatePickerCalendarState extends State<DatePickerCalendar> {
  final String _today = format.stringifyDateTime(DateTime.now());
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  String _currentYYYYMM01 = format.stringifyDateTime01(DateTime.now());

  @override
  void initState() {
    super.initState();
    _focusedDay = format.objectifyDate(widget.defaultDate);
    _selectedDay = format.objectifyDate(widget.defaultDate);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      shouldFillViewport: true,
      // rowHeight: 38,
      daysOfWeekHeight: 60.0,
      daysOfWeekStyle: DaysOfWeekStyle(decoration: BoxDecoration()),
      headerStyle: HeaderStyle(
          headerMargin: EdgeInsets.all(0),
          headerPadding: EdgeInsets.all(0),
          titleCentered: true,
          formatButtonVisible: false,
          decoration: BoxDecoration(color: colors.white)),
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
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            int weekday = selectedDay.weekday;
            widget.onDaySelected(
                format.stringifyDateTime(_selectedDay), weekday);
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call setState
        _focusedDay = focusedDay;
        _currentYYYYMM01 = format.stringifyDateTime01(focusedDay);
        widget.onPageChanged(_currentYYYYMM01);
      },
    );
  }

  // Calendar Builder
  CalendarBuilders getCalendarBuilder() {
    return CalendarBuilders(
      dowBuilder: dowBuilder,
      outsideBuilder: outsideBuilder,
      todayBuilder: todayBuilder,
      defaultBuilder: defaultBuilder,
      selectedBuilder: selectedBuilder,
    );
  }

  Widget dowBuilder(context, date) {
    return Container(
        decoration: BoxDecoration(color: colors.white),
        child: Align(
            alignment: Alignment.center,
            child: Text(format.stringifyWeekday(date.weekday, type: 'short'))));
  }

  Widget outsideBuilder(context, date, event) {
    return dataBuilder(context, date, event, true);
  }

  Widget todayBuilder(context, date, event) {
    return dataBuilder(context, date, event, false);
  }

  Widget defaultBuilder(context, date, event) {
    return dataBuilder(context, date, event, false);
  }

  Widget selectedBuilder(context, date, event) {
    return dataBuilder(context, date, event, false);
  }

  Widget dataBuilder(context, date, event, bool isOutside) {
    String selectedDate = format.stringifyDateTime(_selectedDay);
    String cellDate = format.stringifyDateTime(date);
    bool isSelected = selectedDate == cellDate;

    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: colors.white),
        ),
        isOutside
            ? Container()
            : Align(
                alignment: Alignment.center,
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: isSelected ? colors.active : colors.transparent,
                        borderRadius: borders.radiusCircle),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(date.day.toString(),
                            style: TextStyle(
                              color: isSelected ? colors.white : colors.black,
                              fontSize: fonts.sizeBase,
                              height: fonts.lineHeightBase,
                            ))))),
      ],
    );
  }
}
