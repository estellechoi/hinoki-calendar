import 'package:flutter/material.dart';
import '../widgets/calendars/table_calendar.dart';
// import 'record/write_my_body.dart';
import '../widgets/cards/intro_card.dart';
import '../widgets/cards/f_card.dart';
import '../widgets/styles/paddings.dart' as paddings;

class RecordView extends StatefulWidget {
  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: paddings.verticalBase,
            horizontal: paddings.horizontalBase),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: paddings.card),
              child: IntroCard(
                type: 'border',
                title: '오늘의 기록',
                summary: '기록을 습관화하는 경우, 목표달성을 89% 더 빠르게 할 수 있습니다.',
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: paddings.card),
                child: FCard(title: '성과 달력', body: MyTableCalendar()))
          ],
        ));
  }
}
