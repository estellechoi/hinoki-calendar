import 'package:flutter/material.dart';
import 'dart:collection';
import 'index.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../widgets/calendars/hinoki_table_calendar.dart';
import '../widgets/buttons/f_button.dart';
import '../app_state.dart';
import '../utils/format.dart' as format;
import '../widgets/styles/sizes.dart' as sizes;
import '../widgets/styles/colors.dart' as colors;
import './../widgets/styles/borders.dart' as borders;
import 'home/calendar_daily_modal.dart';
import './../types/calendar_event_item.dart';

// tmp
class CalendarEvent {
  final String date;
  final List<CalendarEventItem> events;

  CalendarEvent({required this.date, required this.events});
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _currentYYYYMM01 = format.stringifyDateTime01(DateTime.now());

  final List<CalendarEvent> list = [
    CalendarEvent(date: '2021-05-05', events: [
      CalendarEventItem(
        id: 1,
        isDone: true,
        order: 1,
        title: '수출법 검토',
        startAt: 'Wed, 17 Mar 2021 11:05:44 GMT',
        date: '2021-05-17',
        color: colors.black,
      ),
      CalendarEventItem(
        id: 2,
        isDone: true,
        order: 2,
        title: '🏋🏽‍♀️ pt수업',
        startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
        date: '2021-05-17',
        color: colors.active,
      ),
      CalendarEventItem(
        id: 3,
        order: 3,
        title: '스터디 밋업',
        startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
        date: '2021-05-17',
        color: colors.black,
      ),
    ]),
    CalendarEvent(date: '2021-05-06', events: [
      CalendarEventItem(
        id: 1,
        isDone: true,
        order: 1,
        title: '수출법 검토',
        startAt: 'Wed, 17 Mar 2021 11:05:44 GMT',
        date: '2021-05-17',
        color: colors.black,
      ),
      CalendarEventItem(
        id: 2,
        isDone: true,
        order: 2,
        title: 'pt수업',
        startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
        date: '2021-05-17',
        color: colors.active,
      ),
      CalendarEventItem(
        id: 3,
        order: 3,
        title: '스터디 밋업',
        startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
        date: '2021-05-17',
        color: colors.black,
      ),
    ]),
    CalendarEvent(date: '2021-05-07', events: [
      CalendarEventItem(
        id: 1,
        isDone: true,
        order: 1,
        title: '수출법 검토',
        startAt: 'Wed, 17 Mar 2021 11:05:44 GMT',
        date: '2021-05-17',
        color: colors.black,
      ),
      CalendarEventItem(
        id: 2,
        isDone: true,
        order: 2,
        title: 'pt수업',
        startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
        date: '2021-05-17',
        color: colors.active,
      ),
      CalendarEventItem(
        id: 3,
        order: 3,
        title: '스터디 밋업',
        startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
        date: '2021-05-17',
        color: colors.black,
      ),
    ]),
  ];

  LinkedHashMap<String, List<CalendarEventItem>> _events =
      LinkedHashMap<String, List<CalendarEventItem>>();

  void _getCalendarEvents() {
    setState(() {
      _events = LinkedHashMap.fromIterable(list,
          key: (item) => item.date.toString(), value: (item) => item.events);
    });
  }

  void _getDataForNewMonth(String date) {
    _currentYYYYMM01 = date;
    _getCalendarEvents();
  }

  void showDailyModal(BuildContext context, String date, int weekday) {
    showMaterialModalBottomSheet(
        context: context,
        shape: ShapeBorder.lerp(borders.modalShape, borders.modalSubShape, 0),
        builder: (context) => CalendarDailyModal(
            date: date,
            weekday: weekday,
            onDismissed: () {
              print('bottom sheet dismissed !');
              _getCalendarEvents();
            }));
  }

  @override
  void initState() {
    super.initState();
    _getCalendarEvents();
  }

  @override
  Widget build(BuildContext context) {
    return NavBarFrame(
        hideAppBar: true,
        bodyWidget: Column(
          children: <Widget>[
            Container(
              height: sizes.appBar,
              decoration: BoxDecoration(color: colors.white),
            ),
            Expanded(
              child: HinokiTableCalendar(
                  events: _events,
                  onPageChanged: _getDataForNewMonth,
                  onDaySelected: (String date, int weekday) {
                    showDailyModal(context, date, weekday);
                  }),
            )
          ],
        ));
  }
}
