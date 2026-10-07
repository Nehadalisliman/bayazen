/*import 'dart:io';

import 'package:dio/dio.dart';
class NetworkUtil{

  String baseUrl;

  Dio dio = Dio();
  Future<Response> post(String url,
      {Map headers, dynamic body, encoding}) async {
    Response response;
    try {
      dio.options.baseUrl = baseUrl;
      response = await dio.post(url,
          data: body,
          options: Options(
              headers: headers,
              requestEncoder: encoding,
              validateStatus: (status) => status <= 500));

      return handleResponse(response);
    } on DioError catch (e) {
      print('\n\n\n post body $body Token $headers url $url && response $response\n\n\n');

      // debugPrint('\n\n\n DioError catch eee response $e\n\n\n', wrapWidth: 800);
      handleError(e);
      return null;
    }
  }

  Future<Response> get(String url,
      {Map<String, dynamic> headers,
        Map<String, dynamic> queryParameters}) async {
    Response response;


    try {
      dio.options.baseUrl = baseUrl;
      if (queryParameters != null) {
        dio.options.queryParameters = queryParameters;
      }
      response = await dio.get(url,
          options: Options(
              headers: headers, validateStatus: (status) => status <= 500));
      return handleResponse(response);
    } on DioError catch (e) {
      handleError(e);
      return null;
    }
  }
  Response handleResponse(Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 401) {

      throw Exception("Unauthorized");
    } else if (statusCode == 422) {
      if(response.data != null){
        if(response.data is Map<dynamic, dynamic>){
          if(response.data['data'] != null){
            if(response.data['data'] is Map<dynamic, dynamic>){
            }
          }
        }
      }
      return response;
    } else if (statusCode >= 400 && statusCode < 500) {
      return response;
    } else if (statusCode != 200) {
      throw Exception(response.toString());
     // FlashHelper().errorBar(message: 'Error with fetching data');
    }

    if (statusCode >= 200 && statusCode < 300) {
      return response;
    } else {
      return response;
    }
  }

  void handleError(DioError e) {
    if (e.error != null && (e.error is SocketException)) {
      throw Exception('No Network');
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout) {
      throw Exception('No Network');
    }
    throw e;
  }
}*/