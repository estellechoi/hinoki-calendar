import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/form_elements/common/shadowed_bundle.dart';
import 'dart:collection';
import '../widgets/layouts/scaffold_layout.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../widgets/calendars/hinoki_table_calendar.dart';
import '../widgets/buttons/f_button.dart';
import '../widgets/form_elements/linked_input.dart';
import '../widgets/buttons/icon_label_button.dart';
import '../store/route_state.dart';
import '../utils/format.dart' as format;
import '../widgets/styles/sizes.dart' as sizes;
import '../widgets/styles/colors.dart' as colors;
import './../widgets/styles/borders.dart' as borders;
import 'home/calendar_daily_modal.dart';
import './../types/calendar_event_item.dart';
import './../types/calendar_event.dart';
import './../constants.dart' as constants;
import 'common/search_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<CalendarEvent> list = constants.dummyEvents;
  String _currentYyyyMm01 = format.stringifyDateTime01(DateTime.now());
  LinkedHashMap<String, List<CalendarEventItem>> _events =
      LinkedHashMap<String, List<CalendarEventItem>>();

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  Future<void> _getEvents() async {
    setState(() {
      _events = LinkedHashMap.fromIterable(list,
          key: (item) => item.date.toString(), value: (item) => item.events);
    });
  }

  void _getEventsForNewMonth(String date) {
    _currentYyyyMm01 = date;
    _getEvents();
  }

  void _showDailyModal(BuildContext context, String date, int weekday) {
    showMaterialModalBottomSheet(
        context: context,
        shape: ShapeBorder.lerp(borders.modalShape, borders.modalSubShape, 0),
        builder: (context) => CalendarDailyModal(
            date: date, weekday: weekday, onDismissed: _getEvents));
  }

  void _handleSearchPress(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchView(
                labelText: 'Search your schedules',
                defaultText: '',
                suggestions: [
                  'Apple',
                  'Banana',
                  'Apartment',
                  'Physics',
                  'Position',
                  'Diet'
                ])));
  }

  PreferredSizeWidget? _buildAppBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, sizes.appBar),
      child: AppBar(
          elevation: 0,
          backgroundColor: colors.white,
          title: Text(_currentYyyyMm01),
          actions: [
            IconLabelButton(
                iconData: Icons.search,
                label: 'Search',
                onPressed: () {
                  _handleSearchPress(context);
                })
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
        appBar: _buildAppBar(),
        refreshable: false,
        // onRefresh: _getEvents,
        body: Container(
            child: Column(
          children: <Widget>[
            Expanded(
              child: HinokiTableCalendar(
                  events: _events,
                  onPageChanged: _getEventsForNewMonth,
                  onDaySelected: (String date, int weekday) {
                    _showDailyModal(context, date, weekday);
                  }),
            )
          ],
        )));
  }
}
