import 'package:flutter/material.dart';
import '../../widgets/styles/paddings.dart' as paddings;
import '../../widgets/styles/borders.dart' as borders;
import '../../widgets/styles/icons.dart' as icons;
import '../../widgets/styles/colors.dart' as colors;
import '../../widgets/styles/fonts.dart' as fonts;
import '../../utils/format.dart' as format;
import '../../types/calendar_event_item.dart';
import '../../widgets/modals/bottom_modal_sheet.dart';

class CalendarDailyModal extends StatefulWidget {
  final String date;
  final int weekday;
  final onDismissed;

  CalendarDailyModal(
      {required this.date, required this.weekday, required this.onDismissed});

  @override
  _CalendarDailyModalState createState() => _CalendarDailyModalState();
}

class _CalendarDailyModalState extends State<CalendarDailyModal> {
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
    String title = '${format.stringifyWeekday(widget.weekday)}, ${widget.date}';

    return BottomModalSheet(
        child: Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: paddings.verticalCard),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          color: colors.black,
                          fontSize: fonts.sizeModalTitle,
                          fontWeight: fonts.weightModalTitle)),
                  Text('+',
                      style: TextStyle(
                          color: colors.black,
                          fontSize: fonts.sizeModalIconButton,
                          fontWeight: fonts.weightModalIconButton))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final item = _events[index];
                  return Dismissible(
                      key: Key(item.id.toString()),
                      onDismissed: (direction) {
                        _dismissEvent(index, item);
                      },
                      direction: DismissDirection.endToStart,
                      background: Container(color: item.color),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(
                                    right:
                                        paddings.modalLabelHorizontalSpacing),
                                decoration: BoxDecoration(
                                    color: colors.transparent,
                                    borderRadius: borders.radiusCircle),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Checkbox(
                                      value: item.isDone,
                                      checkColor: colors.white,
                                      activeColor: item.color,
                                      splashRadius: 5,
                                      onChanged: (value) {
                                        print('checkbox');
                                        print(value);
                                        if (value != null)
                                          _toggleEventDone(item.id, value);
                                      },
                                    ))),
                            Expanded(child: Text(item.title)),
                            Text(format.getHHMM(item.startAt))
                          ],
                        ),
                      ));
                },
              ),
            )
          ],
        ),
        _showDismissAlert
            ? Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                      color: colors.black, borderRadius: borders.radiusLight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('삭제했습니다', style: TextStyle(color: colors.white)),
                      GestureDetector(
                          child: Text('실행취소',
                              style: TextStyle(color: colors.white)),
                          onTap: _cancelEventDismiss)
                    ],
                  ),
                ),
              )
            : Container()
      ],
    ));
  }
}
