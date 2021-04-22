import 'month_body_weight.dart';

class CalendarRecord {
  // final String className;
  final String measurementDay;
  final List<dynamic> monthBodyWeights;

  CalendarRecord({
    // required this.className,
    required this.measurementDay,
    required this.monthBodyWeights,
  });

  factory CalendarRecord.fromJson(Map<String, dynamic> json) {
    return CalendarRecord(
        measurementDay: json['measurement_day'],
        monthBodyWeights: json['month_body_weights'].map((item) {
          return MonthBodyWeight.fromJson(item);
        }).toList());
  }
}
