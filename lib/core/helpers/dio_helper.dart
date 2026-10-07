import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    print('dioHelper Initialized');
    dio = Dio(BaseOptions(
      baseUrl: 'https://bayzin.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<dynamic> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    var headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      return await dio.get(url,
          queryParameters: query,
          options: Options(
            headers: headers,
          ));
    } catch (e) {
      //  log(e.toString());
      return null;
    }
  }
  
Future<void> uploadFileDio(String url, File? file) async {
  var formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file!.path),
  });

}
}
