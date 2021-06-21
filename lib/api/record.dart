import 'package:dio/dio.dart';
import 'config.dart' as config;

Future<dynamic> getMyCalendarData(Map<String, String> param) async {
  try {
    final String url = '/cafe24/user/body_weight/month';
    final Response response =
        await config.http.get(url, queryParameters: param);

    print('getMyCalendarData - Success');
    print(response);
    print(response.statusCode);

    final data = response.data;
    return data;
  } catch (e) {
    print('getMyCalendarData - Fail');
    print(e);
    return e;
  }
}

Future<dynamic> getMyCalendarMenstrualData(Map<String, String> param) async {
  try {
    final String url = '/cafe24/user/menstrual/day';
    final Response response =
        await config.http.get(url, queryParameters: param);

    print('getMyCalendarMenstrualData - Success');
    print(response);
    print(response.statusCode);

    final data = response.data;
    return data;
  } catch (e) {
    print('getMyCalendarMenstrualData - Fail');
    print(e);
  }
}

Future<dynamic> getDailyBodyRecord(Map<String, String> param) async {
  try {
    final String url = '/cafe24/user/body_weight/day';
    final Response response =
        await config.http.get(url, queryParameters: param);

    print('getDailyBodyInfoData - Success');
    print(response);
    print(response.statusCode);

    final data = response.data;
    return data;
  } catch (e) {
    print('getDailyBodyInfoData - Fail');
    print(e);
  }
}

Future<dynamic> deleteDailyBodyRecord(Map<String, String> param) async {
  try {
    final String url = '/cafe24/user/body_weight/day';
    final Response response =
        await config.http.delete(url, queryParameters: param);

    print('deleteDailyBodyRecord - Success');
    print(response);
    print(response.statusCode);

    final data = response.data;
    return data;
  } catch (e) {
    print('deleteDailyBodyRecord - Fail');
    print(e);
  }
}
