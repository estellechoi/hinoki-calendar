import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

final String baseUrl = env['API_URL'].toString();
final String baseUrlPure = baseUrl.substring(8);

final Map<String, String> headers = {
  'Accept': 'application/json',
  'Access-Control-Allow-Origin': '*'
};

final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
