import 'package:dio/dio.dart';
import 'config.dart' as config;

Future<dynamic> login(Map<String, String> param) async {
  try {
    print(config.http.options.baseUrl);

    final String url = '/cafe24/user/login';
    final Response response = await config.http.post(url,
        data: FormData.fromMap(param),
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));

    print('login - Success');
    print(response.statusCode);

    final data = response.data;
    print(data);
    print('');

    // config.headers['Authorization'] = 'Bearer ${data['access_token']}';

    return data;
  } catch (e) {
    print('*********************************************');
    print('login - Fail');
    print(e);
    print('*********************************************');
    print('');

    throw Error();
  }
}
