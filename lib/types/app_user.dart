class AppUser {
  final int id;
  final String accessToken;
  final String name;
  final String birthday;
  final int gender;
  final String phoneNum;

  AppUser(
      {required this.id,
      required this.accessToken,
      required this.name,
      required this.birthday,
      required this.gender,
      required this.phoneNum});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
        id: json['id'].toInt(),
        accessToken: json['access_token'],
        name: json['name'],
        birthday: json['birthday'],
        gender: json['gender'].toInt(),
        phoneNum: json['phone_num']);
  }
}
