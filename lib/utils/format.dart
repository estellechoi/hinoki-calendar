import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

// DateTime to String
String getYYYYMMDD(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

// First Day of Month DateTime
String getYYYYMM01(DateTime dateTime) {
  return DateFormat('yyyy-MM-01').format(dateTime);
}

// String to DateTime
DateTime getDateTime(String dateTime) {
  return DateTime.parse(dateTime);
}

// Fetched String to String
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

// require format of yyyy MM dd
List<int> getYYMMDDSet(String? dateTime) {
  if (dateTime == null || dateTime.length < 1) return [0, 0, 0];

  List<String> splits = dateTime.split(' ');

  int date = int.parse(splits[1]);
  int month = getMMfromMonth(splits[2]);
  int year = int.parse(splits[3]);

  return [year, month, date];
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
  List<int> set = getYYMMDDSet(dateTime);
  return set.indexOf(0) > -1 ? null : Jiffy(set).format('yyyy-MM-dd');
}

String? getHyphenedYYYYMM01(String? dateTime) {
  List<int> set = getYYMMDDSet(dateTime);
  return set.indexOf(0) > -1 ? null : Jiffy(set).format('yyyy-MM-01');
}

int getLastDayOfMonth(String? dateTime) {
  List<int> set = getYYMMDDSetFromHyphend(dateTime);

  if (set.indexOf(0) > -1) return 0;

  DateTime lastDateOfMonth = DateTime(set[0], set[1] + 1, 0);
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
