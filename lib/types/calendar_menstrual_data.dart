class CalendarMenstrualData {
  final double menstrualCycle;
  final double menstrualPeriod;
  final double pmsPeriod;

  final int? prevMenstrualId;
  final String? prevMenstrualStartDate;
  final String? prevMenstrualEndDate;

  final int? nextMenstrualId;
  final String? nextMenstrualStartDate;
  final String? nextMenstrualEndDate;

  // Optional
  final String? contentTitle;
  final String? content;
  final Map<String, dynamic>? irregularityContent;
  final String? memoTitle;
  final List<dynamic>? memo;

  CalendarMenstrualData({
    required this.menstrualCycle,
    required this.menstrualPeriod,
    required this.pmsPeriod,
    this.prevMenstrualId,
    this.prevMenstrualStartDate,
    this.prevMenstrualEndDate,
    this.nextMenstrualId,
    this.nextMenstrualStartDate,
    this.nextMenstrualEndDate,
    this.contentTitle,
    this.content,
    this.irregularityContent,
    this.memoTitle,
    this.memo,
  });

  factory CalendarMenstrualData.fromJson(Map<String, dynamic> json) {
    return CalendarMenstrualData(
      menstrualCycle: json['menstrual_cycle'],
      menstrualPeriod: json['menstrual_period'],
      pmsPeriod: json['pms_period'],
      prevMenstrualId: json['prev_menstrual_id'],
      prevMenstrualStartDate: json['prev_menstrual_start_date'],
      prevMenstrualEndDate: json['prev_menstrual_end_date'],
      nextMenstrualId: json['next_menstrual_id'],
      nextMenstrualStartDate: json['next_menstrual_start_date'],
      nextMenstrualEndDate: json['next_menstrual_end_date'],
      contentTitle: json['content_title'],
      content: json['content'],
      irregularityContent: json['irregularity_content'],
      memoTitle: json['memo_title'],
      memo: json['memo'],
    );
  }
}
