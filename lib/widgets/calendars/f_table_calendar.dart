import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_marker_comment.dart';
import '../styles/textstyles.dart' as textstyles;
import '../styles/sizes.dart' as sizes;
import '../styles/paddings.dart' as paddings;
import '../styles/borders.dart' as borders;
import '../styles/colors.dart' as colors;
import '../styles/shadows.dart' as shadows;
import '../../utils/format.dart' as dateUtil;

class FTableCalendar extends StatefulWidget {
  final LinkedHashMap<String, List<String>> events;
  final LinkedHashMap<String, String> menstrualData;
  final LinkedHashMap<String, String> pmsData;
  final LinkedHashMap<String, String> goldenData;
  final onPageChanged;
  final onDaySelected;

  FTableCalendar({
    Key? key,
    required this.events,
    required this.menstrualData,
    required this.pmsData,
    required this.goldenData,
    required this.onPageChanged,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  _FTableCalendarState createState() => _FTableCalendarState();
}

class _FTableCalendarState extends State<FTableCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  String _currentYYYYMM01 = dateUtil.getYYYYMM01(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            child: TableCalendar(
          locale: 'ko_KR',
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          rowHeight: 70.0,
          daysOfWeekHeight: 60.0,
          daysOfWeekStyle: DaysOfWeekStyle(decoration: BoxDecoration()),
          headerStyle: HeaderStyle(formatButtonVisible: false),
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
                widget.onDaySelected(dateUtil.getYYYYMMDD(_selectedDay));
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call setState
            _focusedDay = focusedDay;
            _currentYYYYMM01 = dateUtil.getYYYYMM01(focusedDay);
            widget.onPageChanged(_currentYYYYMM01);
          },
        )),
        Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                CalendarMarkerComment(label: '생리예상기간', type: 'main'),
                Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child:
                        CalendarMarkerComment(label: '감량 정체기', type: 'range')),
                Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: CalendarMarkerComment(
                        label: '감량 황금기', type: 'colored-text')),
              ],
            ))
      ],
    );
  }

  // Calendar Builder
  CalendarBuilders getCalendarBuilder() {
    return CalendarBuilders(
      // dowBuilder: (context, day) => Align(),
      outsideBuilder: (context, date, events) =>
          Align(child: Container(height: sizes.calendarMarker)),
      todayBuilder: dataBuilder,
      defaultBuilder: dataBuilder,
      selectedBuilder: dataBuilder,
    );
  }

  Widget dataBuilder(context, date, event) {
    bool isFirstDay = date.day == 1;
    bool isLastDay = date.day == dateUtil.getLastDayOfMonth(_currentYYYYMM01);

    bool isSaturday = date.weekday == 6;
    bool isSunday = date.weekday == 7;

    bool isMenstrualDate = false;
    bool isGoldenDate = false;
    bool isPmsDate = false;
    bool isPmsStartDate = false;
    bool isPmsEndDate = false;

    String cellDate = dateUtil.getYYYYMMDD(date);
    List<String> fetchedEvents = widget.events[cellDate] ?? <String>[''];

    String? prevMenstrualStartDate = widget.menstrualData['prevStart'];
    String? prevMenstrualEndDate = widget.menstrualData['prevEnd'];
    String? nextMenstrualStartDate = widget.menstrualData['nextStart'];
    String? nextMenstrualEndDate = widget.menstrualData['nextEnd'];
    String? prevGoldenStartDate = widget.goldenData['prevStart'];
    String? prevGoldenEndDate = widget.goldenData['prevEnd'];
    String? nextGoldenStartDate = widget.goldenData['nextStart'];
    String? nextGoldenEndDate = widget.goldenData['nextEnd'];
    String? prevPmsStartDate = widget.pmsData['prevStart'];
    String? prevPmsEndDate = widget.pmsData['prevEnd'];
    String? nextPmsStartDate = widget.pmsData['nextStart'];
    String? nextPmsEndDate = widget.pmsData['nextEnd'];

    if (prevMenstrualStartDate != null && prevMenstrualEndDate != null) {
      bool isIn1 = dateUtil.isFrontward(prevMenstrualStartDate, cellDate);
      bool isIn2 = dateUtil.isFrontward(cellDate, prevMenstrualEndDate);
      isMenstrualDate = isIn1 && isIn2;
    }

    if (isMenstrualDate == false &&
        nextMenstrualStartDate != null &&
        nextMenstrualEndDate != null) {
      bool isIn1 = dateUtil.isFrontward(nextMenstrualStartDate, cellDate);
      bool isIn2 = dateUtil.isFrontward(cellDate, nextMenstrualEndDate);
      isMenstrualDate = isIn1 && isIn2;
    }

    if (prevGoldenStartDate != null && prevGoldenEndDate != null) {
      bool isIn1 = dateUtil.isFrontward(prevGoldenStartDate, cellDate);
      bool isIn2 = dateUtil.isFrontward(cellDate, prevGoldenEndDate);
      isGoldenDate = isIn1 && isIn2;
    }

    if (isGoldenDate == false &&
        nextGoldenStartDate != null &&
        nextGoldenEndDate != null) {
      bool isIn1 = dateUtil.isFrontward(nextGoldenStartDate, cellDate);
      bool isIn2 = dateUtil.isFrontward(cellDate, nextGoldenEndDate);
      isGoldenDate = isIn1 && isIn2;
    }

    if (prevPmsStartDate != null && prevPmsEndDate != null) {
      bool isIn1 = dateUtil.isFrontward(prevPmsStartDate, cellDate);
      bool isIn2 = dateUtil.isFrontward(cellDate, prevPmsEndDate);
      isPmsDate = isIn1 && isIn2;
      isPmsStartDate = prevPmsStartDate == cellDate;
      isPmsEndDate = prevPmsEndDate == cellDate;
    }

    if (isPmsDate == false &&
        nextPmsStartDate != null &&
        nextPmsEndDate != null) {
      bool isIn1 = dateUtil.isFrontward(nextPmsStartDate, cellDate);
      bool isIn2 = dateUtil.isFrontward(cellDate, nextPmsEndDate);
      isPmsDate = isIn1 && isIn2;

      if (isPmsStartDate == false) {
        isPmsStartDate = nextPmsStartDate == cellDate;
      }

      if (isPmsEndDate == false) {
        isPmsEndDate = nextPmsEndDate == cellDate;
      }
    }

    final bool isRadiusLeft = isSunday || isFirstDay || isPmsStartDate;
    final bool isRadiusRight = isSaturday || isLastDay || isPmsEndDate;
    final bool isRadiusHorizontal = isSunday && isLastDay ||
        isSunday && isPmsEndDate ||
        isFirstDay && isPmsEndDate ||
        isSaturday && isFirstDay ||
        isSaturday && isPmsStartDate ||
        isLastDay && isPmsStartDate;

    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: 29.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isPmsDate
                    ? colors.calendarRangeColoredCell
                    : colors.transparent,
                border: borders.none,
                borderRadius: isRadiusHorizontal
                    ? borders.radiusCalendarHorizontal
                    : isRadiusRight
                        ? borders.radiusCalendarRight
                        : isRadiusLeft
                            ? borders.radiusCalendarLeft
                            : borders.radiusNone),
          ),
          Container(
              width: sizes.calendarMarker,
              height: sizes.calendarMarker,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isMenstrualDate ? colors.white : colors.transparent,
                  boxShadow: isMenstrualDate ? shadows.calendarStrongcell : [],
                  border: isMenstrualDate
                      ? borders.calendarStrongCell
                      : borders.none,
                  borderRadius: borders.radiusCircle),
              child: Text(date.day.toString(),
                  style: isGoldenDate
                      ? textstyles.calendarColored
                      : textstyles.calendarStrongCell)),
          Positioned(
            left: 0,
            right: 0,
            bottom: -20,
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Text((fetchedEvents[0]).toString(),
                        style: textstyles.calendarEvent))
              ],
            ),
          )
        ],
      ),
    );
  }
}
