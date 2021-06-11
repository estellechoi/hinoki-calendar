// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return AppUser(
    id: json['id'] as int,
    accessToken: json['access_token'] as String,
    name: json['name'] as String,
    birthday: json['birthday'] as String,
    gender: json['gender'] as int,
    phoneNum: json['phone_num'] as String,
  );
}

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'access_token': instance.accessToken,
      'name': instance.name,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'phone_num': instance.phoneNum,
    };
