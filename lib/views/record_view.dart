import 'package:flutter/material.dart';
import '../widgets/calendars/table_calendar.dart';
import '../widgets/charts/f_line_chart.dart';
import '../widgets/charts/f_bar_chart.dart';
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
                  buttonType: 'blue'),
            ),
            Container(
              padding: EdgeInsets.only(bottom: paddings.card),
              child: IntroCard(
                title: '생리주기 관리존',
                summary: '호르몬 주기로 본 감량 황금기와 정체기는 언제일까? 지금 최상의 시기를 알아보세요.',
                buttonType: 'fountainBlue',
                emojiText: '🌙',
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: paddings.card),
                child: FCard(title: '체중', body: FLineChart())),
            Container(
                padding: EdgeInsets.only(bottom: paddings.card),
                child: FCard(title: '케톤수치', body: FBarChart())),
            Container(
                padding: EdgeInsets.only(bottom: paddings.card),
                child: FCard(title: '혈당수치', body: FBarChart(color: 'sugar'))),
            Container(
                padding: EdgeInsets.only(bottom: paddings.card),
                child: FCard(title: '성과 달력', body: MyTableCalendar()))
          ],
        ));
  }
}
