import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../styles/textstyles.dart' as textstyles;
import '../styles/sizes.dart' as sizes;
import '../styles/paddings.dart' as paddings;
import '../styles/borders.dart' as borders;
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/shadows.dart' as shadows;
import '../../utils/format.dart' as format;
import './../../types/calendar_event_item.dart';

class HinokiTableCalendar extends StatefulWidget {
  final LinkedHashMap<String, List<CalendarEventItem>> events;
  final onPageChanged;
  final onDaySelected;

  HinokiTableCalendar({
    Key? key,
    required this.events,
    required this.onPageChanged,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  _HinokiTableCalendarState createState() => _HinokiTableCalendarState();
}

class _HinokiTableCalendarState extends State<HinokiTableCalendar> {
  late final String _today;
  late final String _thisMonthYYYYMM01;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  String _currentYYYYMM01 = format.stringifyDateTime01(DateTime.now());

  @override
  void initState() {
    super.initState();
    _today = format.stringifyDateTime(_selectedDay);
    _thisMonthYYYYMM01 = _currentYYYYMM01;
  }

  String _buildHeaderTitle(DateTime dateTime, dynamic value) {
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            shouldFillViewport: true,
            // rowHeight: sizes.getBodyHeight(context) / 7,
            daysOfWeekHeight: 60.0,
            daysOfWeekStyle: DaysOfWeekStyle(decoration: BoxDecoration()),
            headerStyle: HeaderStyle(
                headerMargin: EdgeInsets.all(0),
                headerPadding: EdgeInsets.all(0),
                titleCentered: true,
                formatButtonVisible: false,
                decoration: BoxDecoration(color: colors.white),
                titleTextFormatter: _buildHeaderTitle),
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
          ),
        )
      ],
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
    // bool isFirstDay = date.day == 1;
    // bool isLastDay = date.day == format.getLastDayOfMonth(_currentYYYYMM01);

    // bool isSaturday = date.weekday == 6;
    // bool isSunday = date.weekday == 7;

    String selectedDate = format.stringifyDateTime(_selectedDay);
    String cellDate = format.stringifyDateTime(date);

    bool isToday = cellDate == _today;
    bool isSelected = selectedDate == cellDate;

    List<CalendarEventItem> fetchedEvents = widget.events[cellDate] ?? const [];

    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: colors.white),
        ),
        Container(
            clipBehavior: Clip.hardEdge,
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                color: isSelected
                    ? isOutside
                        ? colors.blackAlpha
                        : colors.black
                    : colors.transparent,
                borderRadius: borders.radiusLight),
            child: Column(
              children: [
                SizedBox(
                  height: 4,
                ),
                Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    // padding: EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                        color: isToday ? colors.black : colors.transparent,
                        borderRadius: borders.radiusCircle),
                    child: Text(date.day.toString(),
                        style: TextStyle(
                            color: isToday || isSelected
                                ? colors.white
                                : colors.black,
                            fontSize: fonts.sizeBase,
                            height: fonts.lineHeightBase,
                            fontFamily: fonts.primary,
                            fontFamilyFallback: fonts.primaryFallbacks))),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getEventsColumn(fetchedEvents, isSelected)),
                ),
              ],
            )),
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
              color: isOutside ? colors.whiteAlphaDeep : colors.transparent),
        )
      ],
    );
  }

  List<Widget> getEventsColumn(fetchedEvents, isSelected) {
    return [
      for (var item in fetchedEvents)
        Container(
            alignment: Alignment.topLeft,
            child: Text(item.title,
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: isSelected ? colors.white : item.color,
                    fontSize: fonts.sizeCalendarEvent,
                    height: fonts.lineHeightBase,
                    decoration: item.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)))
    ];
  }
}
