class DailyBodyRecord {
  final double appetite;
  final double bloodSugar;
  final double condition;
  final double ketoneValue;
  final double height;
  final double weight;
  final String intake;
  final String measurementDay;
  final String measurementType;
  final String memo;
  final bool isEditMode;

  DailyBodyRecord(
      {required this.appetite,
      required this.bloodSugar,
      required this.condition,
      required this.ketoneValue,
      required this.height,
      required this.weight,
      required this.intake,
      required this.measurementDay,
      required this.measurementType,
      required this.memo,
      required this.isEditMode});

  factory DailyBodyRecord.fromJson(Map<String, dynamic> json) {
    double parseToDouble(dynamic data) {
      return data == '' || data == null ? 0 : data.toDouble();
    }

    return DailyBodyRecord(
        appetite: parseToDouble(json['appetite']),
        bloodSugar: parseToDouble(json['blood_sugar']),
        condition: parseToDouble(json['condition']),
        ketoneValue: parseToDouble(json['ketone_value']),
        height: parseToDouble(json['height']),
        weight: parseToDouble(json['weight']),
        intake: json['intake'] ?? '',
        measurementDay: json['measurement_day'] ?? '',
        measurementType: json['measurement_type'] ?? 'breath',
        memo: json['memo'] ?? '',
        isEditMode: json['weight'] != '');
  }
}
