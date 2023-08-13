import 'package:dio/dio.dart';

class ApiConfig {
  static final Dio api = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080',
    ),
  );

  static String? apiErrorMessagesToString(Response? response) {
    if (response != null && response.data != null) {
      if (response.data['message'] is List) {
        return (response.data['message'] as List).join('\n');
      }
      return response.data['message'] as String;
    }
    return '';
  }
}
