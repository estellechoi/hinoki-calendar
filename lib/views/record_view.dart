import 'package:flutter/material.dart';
import 'dart:collection';
import '../widgets/calendars/f_table_calendar.dart';
import '../widgets/charts/f_line_chart.dart';
import '../widgets/charts/f_bar_chart.dart';
import '../widgets/cards/intro_card.dart';
import '../widgets/cards/f_card.dart';
import '../widgets/styles/paddings.dart' as paddings;
import '../api/record.dart' as api;
import '../types/calendar_record.dart';
import '../types/calendar_menstrual_data.dart';
import '../utils/format.dart' as format;
import '../app_state.dart';
import '../route/pages.dart';
import 'index.dart';

class RecordView extends StatefulWidget {
  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  LinkedHashMap<String, List<String>> _bodyRecords =
      LinkedHashMap<String, List<String>>();

  LinkedHashMap<String, String> _menstrualData =
      LinkedHashMap<String, String>();
  LinkedHashMap<String, String> _pmsData = LinkedHashMap<String, String>();
  LinkedHashMap<String, String> _goldenData = LinkedHashMap<String, String>();
  String _currentYYYYMM01 = format.stringifyDateTime01(DateTime.now());

  Future getMyCalendarData() async {
    try {
      final Map<String, String> param = {'measurement_day': _currentYYYYMM01};
      final data = await api.getMyCalendarData(param);
      CalendarRecord record = CalendarRecord.fromJson(data);

      setState(() {
        _bodyRecords = LinkedHashMap.fromIterable(record.monthBodyWeights,
            key: (item) => item.start.toString(),
            value: (item) => <String>[
                  '${item.title >= 0 ? '+' : ''}${(item.title * 1000).toInt()}g'
                ]);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getMyCalendarMenstrualData() async {
    try {
      const int pmsEndDiff = 7;
      const int goldenStartDiff = 11;
      const int goldenEndDiff = 20;

      final Map<String, String> param = {'menstrual_date': _currentYYYYMM01};
      final data = await api.getMyCalendarMenstrualData(param);
      final CalendarMenstrualData menstrualData =
          CalendarMenstrualData.fromJson(data);

      // prev
      final String? prevMenstrualStartDate =
          format.getHyphenedYYYYMMDD(menstrualData.prevMenstrualStartDate);
      String? prevMenstrualEndDate;
      String? prevPmsStartDate;
      String? prevPmsEndDate;
      String? prevGoldenStartDate;
      String? prevGoldenEndDate;

      if (prevMenstrualStartDate != null) {
        prevMenstrualEndDate =
            format.getHyphenedYYYYMMDD(menstrualData.prevMenstrualEndDate);
        prevPmsStartDate = format.manipulateHyphenedYYYYMMDD(
            prevMenstrualStartDate, -(menstrualData.pmsPeriod.toInt() + 1));
        prevPmsEndDate =
            format.manipulateHyphenedYYYYMMDD(prevPmsStartDate, pmsEndDiff);
        prevGoldenStartDate = format.manipulateHyphenedYYYYMMDD(
            prevPmsStartDate, goldenStartDiff);
        prevGoldenEndDate =
            format.manipulateHyphenedYYYYMMDD(prevPmsStartDate, goldenEndDiff);
      }

      // next
      final String? nextMenstrualStartDate =
          format.getHyphenedYYYYMMDD(menstrualData.nextMenstrualStartDate);
      String? nextMenstrualEndDate;
      String? nextPmsStartDate;
      String? nextPmsEndDate;
      String? nextGoldenStartDate;
      String? nextGoldenEndDate;

      if (nextMenstrualStartDate != null) {
        nextMenstrualEndDate =
            format.getHyphenedYYYYMMDD(menstrualData.nextMenstrualEndDate);
        nextPmsStartDate = format.manipulateHyphenedYYYYMMDD(
            nextMenstrualStartDate, -(menstrualData.pmsPeriod.toInt() + 1));
        nextPmsEndDate =
            format.manipulateHyphenedYYYYMMDD(nextPmsStartDate, pmsEndDiff);
        nextGoldenStartDate = format.manipulateHyphenedYYYYMMDD(
            nextPmsStartDate, goldenStartDiff);
        nextGoldenEndDate =
            format.manipulateHyphenedYYYYMMDD(nextPmsStartDate, goldenEndDiff);
      }

      if (prevMenstrualStartDate != null &&
          prevMenstrualEndDate != null &&
          prevPmsStartDate != null &&
          prevPmsEndDate != null &&
          prevGoldenStartDate != null &&
          prevGoldenEndDate != null &&
          nextMenstrualStartDate != null &&
          nextMenstrualEndDate != null &&
          nextPmsStartDate != null &&
          nextPmsEndDate != null &&
          nextGoldenStartDate != null &&
          nextGoldenEndDate != null) {
        // prev golden & next pms duplication handling
        if (prevMenstrualStartDate != nextMenstrualStartDate &&
            format.isBackward(prevGoldenEndDate, nextPmsStartDate)) {
          // if next pms covers prev golden period
          if (format.isBackward(prevGoldenStartDate, nextPmsStartDate)) {
            prevGoldenStartDate = null;
            prevGoldenEndDate = null;
          } else {
            prevGoldenEndDate =
                format.manipulateHyphenedYYYYMMDD(nextPmsStartDate, -1);
          }
        }
      }

      // Get states done !
      setState(() {
        if (prevMenstrualStartDate != null &&
            prevMenstrualEndDate != null &&
            prevPmsStartDate != null &&
            prevPmsEndDate != null &&
            prevGoldenStartDate != null &&
            prevGoldenEndDate != null) {
          _menstrualData.addAll({
            'prevStart': prevMenstrualStartDate,
            'prevEnd': prevMenstrualEndDate
          });

          _pmsData.addAll(
              {'prevStart': prevPmsStartDate, 'prevEnd': prevPmsEndDate});
          _goldenData.addAll(
              {'prevStart': prevGoldenStartDate, 'prevEnd': prevGoldenEndDate});
        }

        if (nextMenstrualStartDate != null &&
            nextMenstrualEndDate != null &&
            nextPmsStartDate != null &&
            nextPmsEndDate != null &&
            nextGoldenStartDate != null &&
            nextGoldenEndDate != null) {
          _menstrualData.addAll({
            'nextStart': nextMenstrualStartDate,
            'nextEnd': nextMenstrualEndDate,
          });
          _pmsData.addAll({
            'nextStart': nextPmsStartDate,
            'nextEnd': nextPmsEndDate,
          });
          _goldenData.addAll({
            'nextStart': nextGoldenStartDate,
            'nextEnd': nextGoldenEndDate,
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _getDataForNewMonth(String date) {
    setState(() {
      _currentYYYYMM01 = date;
      getMyCalendarData();
      getMyCalendarMenstrualData();
    });
  }

  void _goRecordBody(String date) {
    appState.pushNavigation(fetchRecordBodyPageConfig(date));

    // how to get return data when the pushed nav popped ?
  }

  @override
  void initState() {
    super.initState();
    getMyCalendarData();
    getMyCalendarMenstrualData();
  }

  @override
  Widget build(BuildContext context) {
    return NavBarFrame(
        bodyWidget: Container(
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
                    child:
                        FCard(title: '혈당수치', body: FBarChart(color: 'sugar'))),
                Container(
                    padding: EdgeInsets.only(bottom: paddings.card),
                    child: FCard(
                        title: '성과 달력',
                        body: FTableCalendar(
                            events: _bodyRecords,
                            menstrualData: _menstrualData,
                            pmsData: _pmsData,
                            goldenData: _goldenData,
                            onPageChanged: _getDataForNewMonth,
                            onDaySelected: _goRecordBody)))
              ],
            )));
  }
}
