import 'package:dio/dio.dart';
import 'config.dart' as config;

Future<dynamic> getGuideUnreadCnt() async {
  try {
    final String url = '/api/content/unread';
    final Response response =
        await config.dio.get(url, options: Options(headers: config.headers));

    print('getGuideUnreadCnt - Success');
    print(response);
    print(response.statusCode);

    final data = response.data;
    return data;
  } catch (e) {
    print('getGuideUnreadCnt - Fail');
    print(e);
    return e;
  }
}

Future<dynamic> getGuideCategories() async {
  try {
    final String url = '/api/content/category';
    final Response response =
        await config.dio.get(url, options: Options(headers: config.headers));

    print('getGuideCategories - Success');
    print(response);
    print(response.statusCode);

    final data = response.data;
    return data;
  } catch (e) {
    print('getGuideCategories - Fail');
    print(e);
    return e;
  }
}

Future<dynamic> getGuideCategoryById(String id) async {
  try {
    final String url = '/api/content/category/$id';
    final Response response =
        await config.dio.get(url, options: Options(headers: config.headers));

    print('getGuideCategoryById - Success');
    print(response);
    print(response.statusCode);

    final data = response.data;
    return data;
  } catch (e) {
    print('getGuideCategoryById - Fail');
    print(e);
    return e;
  }
}

Future<dynamic> getGuideContentById(String id) async {
  try {
    final String url = '/api/contents/$id';
    final Response response =
        await config.dio.get(url, options: Options(headers: config.headers));

    print('getGuideContentById - Success');
    print(response);
    print(response.statusCode);

    final data = response.data;
    return data;
  } catch (e) {
    print('getGuideContentById - Fail');
    print(e);
    return e;
  }
}

Future<dynamic> postGuideContentRead(String id) async {
  try {
    final String url = '/api/contents/$id';
    final Response response =
        await config.dio.post(url, options: Options(headers: config.headers));

    print('postGuideContentRead - Success');
    print(response);
    print(response.statusCode);

    final data = response.data;
    return data;
  } catch (e) {
    print('postGuideContentRead - Fail');
    print(e);
    return e;
  }
}
