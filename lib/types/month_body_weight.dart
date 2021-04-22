class MonthBodyWeight {
  // final String className;
  final String start;
  final double title;

  MonthBodyWeight({
    // required this.className,
    required this.start,
    required this.title,
  });

  factory MonthBodyWeight.fromJson(Map<String, dynamic> json) {
    return MonthBodyWeight(
      start: json['start'],
      title: json['title'],
    );
  }
}
