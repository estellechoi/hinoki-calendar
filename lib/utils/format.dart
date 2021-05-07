import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

// DateTime to String
String stringifyDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

// First Day of Month DateTime
String stringifyDateTime01(DateTime dateTime) {
  return DateFormat('yyyy-MM-01').format(dateTime);
}

int getMMfromMonth(String month) {
  if (month.length < 3) return 0;

  late final int mm;

  switch (month) {
    case 'Jan':
      mm = 1;
      break;
    case 'Feb':
      mm = 2;
      break;
    case 'Mar':
      mm = 3;
      break;
    case 'Apr':
      mm = 4;
      break;
    case 'May':
      mm = 5;
      break;
    case 'Jun':
      mm = 6;
      break;
    case 'Jul':
      mm = 7;
      break;
    case 'Aug':
      mm = 8;
      break;
    case 'Sep':
      mm = 9;
      break;
    case 'Oct':
      mm = 10;
      break;
    case 'Nov':
      mm = 11;
      break;
    case 'Dec':
      mm = 12;
      break;
    default:
      mm = 0;
  }

  return mm;
}

String stringifyWeekday(int weekday, {String type = 'default'}) {
  if (weekday < 1 || weekday > 7) {
    return '';
  }

  bool short = type == 'short';

  switch (weekday) {
    case 1:
      return short ? 'M' : 'Mon';
    case 2:
      return short ? 'T' : 'Tue';
    case 3:
      return short ? 'W' : 'Wed';
    case 4:
      return short ? 'T' : 'Thu';
    case 5:
      return short ? 'F' : 'Fri';
    case 6:
      return short ? 'S' : 'Sat';
    case 7:
      return short ? 'S' : 'Sun';
    default:
      return '';
  }
}

// require format of 'Wed, 17 Mar 2021 10:59:44 GMT'
List<int> listifyFetchedDateTime(String? dateTime) {
  if (dateTime == null || dateTime.length < 1) return [0, 0, 0, 0, 0, 0];

  List<String> splits = dateTime.split(' ');

  // yyyy MM dd
  int date = int.parse(splits[1]);
  int month = getMMfromMonth(splits[2]);
  int year = int.parse(splits[3]);

  // hh mm ss
  List<String> times = splits[4].split(':');
  int hour = int.parse(times[0]);
  int min = int.parse(times[1]);
  int sec = int.parse(times[2]);

  return [year, month, date, hour, min, sec];
}

// require format of 'Wed, 17 Mar 2021 10:59:44 GMT'
String getHHMM(String? dateTime) {
  List<int> list = listifyFetchedDateTime(dateTime);
  return '${prefixWithZero(list[3].toString())} : ${prefixWithZero(list[4].toString())}';
}

// require format of 'Wed, 17 Mar 2021 10:59:44 GMT'
List<int> getFromNow(String dateTime) {
  List<int> timeSet = listifyFetchedDateTime(dateTime);

  if (timeSet[0] == 0) return [0, 0, 0];

  var target = Jiffy(timeSet);
  var now = Jiffy(DateTime.now());

  final int leftSecondes = now.diff(target, Units.SECOND).toInt();
  final bool isLeft = leftSecondes < 0;
  final int positive = isLeft ? -leftSecondes : leftSecondes;

  var leftHours = positive ~/ 3600;
  var leftMins = (positive % 3600).toInt() ~/ 60;
  var leftSecs = (positive % 60).toInt();

  return [leftHours, leftMins, leftSecs];
}

// require format of 'Wed, 17 Mar 2021 10:59:44 GMT'
String getLeftHHMM(String dateTime) {
  List<int> fromNow = getFromNow(dateTime);

  int hour = fromNow[0];
  int min = fromNow[1];

  return '$hour시간 $min분';
}

// require format of yyyy-MM-dd
List<int> getYYMMDDSetFromHyphend(String? dateTime) {
  if (dateTime == null || dateTime.indexOf('-') < 0) return [0, 0, 0];

  List<String> splits = dateTime.split('-');

  int year = int.parse(splits[0]);
  int month = int.parse(splits[1]);
  int date = int.parse(splits[2]);

  return [year, month, date];
}

String? getHyphenedYYYYMMDD(String? dateTime) {
  List<int> timeSet = listifyFetchedDateTime(dateTime);
  return timeSet.every((item) => item == 0)
      ? null
      : Jiffy(timeSet).format('yyyy-MM-dd');
}

String? getHyphenedYYYYMM01(String? dateTime) {
  List<int> timeSet = listifyFetchedDateTime(dateTime);
  return timeSet.every((item) => item == 0)
      ? null
      : Jiffy(timeSet).format('yyyy-MM-01');
}

int getLastDayOfMonth(String? dateTime) {
  List<int> timeSet = getYYMMDDSetFromHyphend(dateTime);

  if (timeSet.every((item) => item == 0)) return 0;

  DateTime lastDateOfMonth = DateTime(timeSet[0], timeSet[1] + 1, 0);
  return lastDateOfMonth.day;
}

// from hyphenedDate
String manipulateHyphenedYYYYMMDD(String hyphenedDate, int days) {
  return days >= 0
      ? Jiffy(hyphenedDate).add(days: days).format('yyyy-MM-dd')
      : Jiffy(hyphenedDate).subtract(days: -days).format('yyyy-MM-dd');
}

int getDateDiffMs(String dateTime1, String dateTime2) {
  return Jiffy(dateTime1, 'yyyy-MM-dd')
      .diff(Jiffy(dateTime2, 'yyyy-MM-dd'), Units.DAY)
      .toInt();
}

bool isFrontward(String dateTime1, String dateTime2) {
  return getDateDiffMs(dateTime1, dateTime2) <= 0;
}

bool isBackward(String dateTime1, String dateTime2) {
  return getDateDiffMs(dateTime1, dateTime2) >= 0;
}

String prefixWithZero(String number) {
  if (number.length < 1) return '0';

  final bool isLessTen = number.length < 2;
  if (isLessTen == true)
    return '0$number';
  else
    return number;
}
