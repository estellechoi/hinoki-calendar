import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

final String baseUrl = env['API_URL'].toString();
final String baseUrlPure = baseUrl.substring(8);

final Map<String, String> headers = {
  'Accept': 'application/json',
  'Access-Control-Allow-Origin': '*'
};

final Dio http = getDio();

Dio getDio() {
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    // Do something before request is sent
    return handler.next(options); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onResponse: (response, handler) {
    // Do something with response data
    return handler.next(response); // continue
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onError: (DioError e, handler) {
    // Do something with response error
    return handler.next(e); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
  }));

  return dio;
}
