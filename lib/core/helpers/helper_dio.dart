import 'package:dio/dio.dart';
import 'package:e_learning/core/Services/urls.dart';

class HelperDio {
  static Future<Response> post({
    required String endpoint,
    dynamic data,
    String? token,
  }) async {
    return await Dio().post(
      '${Urls.baseUrl + endpoint}',
      data: data,
      options: Options(headers: {"authorization": 'Bearer $token'}),
      queryParameters: {
        "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest"
      },
    );
  }

  static Future<Response> get({
    required String endpoint,
    dynamic data,
    String? token,
  }) async {
    return await Dio().get(
      '${Urls.baseUrl + endpoint}',
      options: Options(headers: {"authorization": 'Bearer $token'}),
      data: data,
      queryParameters: {
        "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest",

      },
    );
  }
}
