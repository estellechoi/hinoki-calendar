import 'package:flutter/material.dart';
import '../../widgets/styles/paddings.dart' as paddings;
import '../../widgets/styles/borders.dart' as borders;
import '../../widgets/styles/icons.dart' as icons;
import '../../widgets/styles/colors.dart' as colors;
import '../../widgets/styles/fonts.dart' as fonts;
import '../../widgets/styles/shadows.dart' as shadows;

import '../../utils/format.dart' as format;
import '../../types/calendar_event_item.dart';
import '../../widgets/modals/bottom_modal_sheet.dart';
import '../../widgets/buttons/icon_label_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import './../../widgets/buttons/text_label_button.dart';
import './../../widgets/form_elements/linked_input.dart';
import './../../widgets/form_elements/linked_switch.dart';
import './../../widgets/form_elements/linked_date_picker.dart';
import './../../widgets/form_elements/linked_time_picker.dart';

class CalendarWriteModal extends StatefulWidget {
  final String date;
  final int weekday;
  final onDismissed;

  CalendarWriteModal(
      {required this.date, required this.weekday, required this.onDismissed});

  @override
  _CalendarWriteModalState createState() => _CalendarWriteModalState();
}

class _CalendarWriteModalState extends State<CalendarWriteModal> {
  List<CalendarEventItem> _events = [];
  List<CalendarEventItem> _dismissingEvents = [];
  bool _showDismissAlert = false;

  Future _getDailyEvents() async {
    setState(() {
      _events = [
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
      ];
    });
  }

  Future _toggleEventDone(int id, bool isDone) async {
    // api 응답에 따라...
    setState(() {
      _events = [
        CalendarEventItem(
          id: 1,
          isDone: isDone,
          order: 1,
          title: '수출법 검토',
          startAt: 'Wed, 17 Mar 2021 11:05:44 GMT',
          date: '2021-05-17',
          color: colors.black,
        ),
        CalendarEventItem(
          id: 2,
          isDone: isDone,
          order: 2,
          title: 'pt수업',
          startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
          date: '2021-05-17',
          color: colors.active,
        ),
        CalendarEventItem(
          id: 3,
          isDone: isDone,
          order: 3,
          title: '스터디 밋업',
          startAt: 'Wed, 17 Mar 2021 10:59:44 GMT',
          date: '2021-05-17',
          color: colors.black,
        ),
      ];
    });
  }

  Future _deleteEvent(CalendarEventItem item) async {
    // api 호출
    bool isDismissing =
        _dismissingEvents.any((element) => element.id == item.id);

    if (isDismissing) {
      _dismissingEvents.remove(item);

      setState(() {
        // only if this is the last dismissing event
        if (_dismissingEvents.length == 0) {
          _showDismissAlert = false;
        }
      });
    }
  }

  void startTimerToConfirm(CalendarEventItem item) {
    setState(() {
      if (_showDismissAlert) {
        _showDismissAlert = false;
      }
    });

    setState(() {
      _dismissingEvents.add(item);
      _showDismissAlert = true;
    });

    Future.delayed(Duration(seconds: 5)).whenComplete(() {
      _deleteEvent(item);
    }).catchError((err) {
      print(err);
    });
  }

  void _dismissEvent(int index, CalendarEventItem item) {
    setState(() {
      _events.removeAt(index);
    });

    startTimerToConfirm(item);
  }

  void _cancelEventDismiss() {
    CalendarEventItem lastItem =
        _dismissingEvents[_dismissingEvents.length - 1];

    setState(() {
      _events.add(lastItem);
      _events.sort((a, b) => a.order.compareTo(b.order));
      _dismissingEvents.remove(lastItem);
      _showDismissAlert = false;
    });
  }

  void showWriteModal(BuildContext context) {
    // , String date, int weekday
    showMaterialModalBottomSheet(
        context: context,
        shape: ShapeBorder.lerp(borders.modalShape, borders.modalSubShape, 0),
        builder: (context) => CalendarWriteModal(
            date: widget.date,
            weekday: widget.weekday,
            onDismissed: () {
              print('bottom sheet dismissed !');
              // _getCalendarEvents();
            }));
  }

  bool _isPeriod = false;

  void _printInput(String text) {
    print(text);
  }

  @override
  void initState() {
    super.initState();
    _getDailyEvents();
  }

  @override
  void dispose() {
    widget.onDismissed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomModalSheet(
        child: Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(bottom: paddings.verticalCard),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextLabelButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: 'Cancel'),
                  Text('New Event',
                      style: TextStyle(
                          color: colors.black,
                          fontSize: fonts.sizeBase,
                          fontWeight: fonts.weightModalTitle)),
                  TextLabelButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: 'Save'),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(boxShadow: shadows.input),
                      child: LinkedInput(
                          position: 'single',
                          labelText: 'Title',
                          defaultValue: '',
                          onChanged: _printInput),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(boxShadow: shadows.input),
                        child: Column(
                          children: <Widget>[
                            LinkedSwitch(
                                position: 'top',
                                labelText: 'Period',
                                isActive: _isPeriod,
                                onToggle: (bool val) {
                                  setState(() {
                                    _isPeriod = val;
                                  });
                                }),
                            LinkedDatePicker(
                                position: 'middle',
                                labelText: _isPeriod ? 'Starts' : 'Date',
                                defaultDate: widget.date),
                            _isPeriod
                                ? LinkedDatePicker(
                                    position: 'bottom',
                                    labelText: 'Ends',
                                    defaultDate: widget.date)
                                : LinkedTimePicker(
                                    position: 'bottom',
                                    labelText: 'Time',
                                    defaultTime: widget.date)
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(boxShadow: shadows.input),
                        child: Column(
                          children: <Widget>[
                            LinkedInput(
                                position: 'top',
                                labelText: 'URL',
                                defaultValue: '',
                                onChanged: _printInput),
                            LinkedInput(
                                position: 'bottom',
                                type: 'textarea',
                                labelText: 'Notes',
                                defaultValue: '',
                                onChanged: _printInput)
                          ],
                        ))
                  ],
                ))),
          ],
        ),
      ],
    ));
  }
}
