import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "access_token")
  final String accessToken;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "birthday")
  final String birthday;

  @JsonKey(name: "gender")
  final int gender;

  @JsonKey(name: "phone_num")
  final String phoneNum;

  AppUser(
      {required this.id,
      required this.accessToken,
      required this.name,
      required this.birthday,
      required this.gender,
      required this.phoneNum});

  // factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
  //     id: json['id'].toInt(),
  //     accessToken: json['access_token'],
  //     name: json['name'],
  //     birthday: json['birthday'],
  //     gender: json['gender'].toInt(),
  //     phoneNum: json['phone_num']);

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'accessToken': accessToken,
  //       'name': name,
  //       'birthday': birthday,
  //       'gender': gender,
  //       'phoneNum': phoneNum
  //     };

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
