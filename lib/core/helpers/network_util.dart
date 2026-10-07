import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/core/helpers/handel_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkUtil {
  String? baseUrl;

  Dio dio = Dio();
  Future<dynamic> post(String url, {dynamic body, encoding}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');

    var headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response;
    try {
      dio.options.baseUrl = baseUrl!;
      response = await dio.post(url,
          data: body,
          options: Options(
              headers: headers,
              requestEncoder: encoding,
              validateStatus: (status) => status! <= 500),
          onSendProgress: (int sent, int total) {
        var valeu = (sent / total) * 100;

        log("${valeu.toInt()}");
      });
      print("response$response");

      return response;
    } on DioError catch (e) {
      DioExceptions.fromDioError(e);
      final String? error = DioExceptions.message;
      print("errorMessage.AuthService: $error");
      log("errorMessage.AuthService: $error");
      return "errorMessage.AuthService: $error";
    }
  }

  Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    log("TOKEN : $token");
    var headers = {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    };

    var response;
    try {
      dio.options.baseUrl = baseUrl!;
      if (queryParameters != null) {
        dio.options.queryParameters = queryParameters;
      }
      response = await dio.get(url,
          queryParameters: queryParameters,
          options: Options(
              headers: headers, validateStatus: (status) => status! <= 500));

      if (response.data['message'] == "success") {
        log("true");
        return response;
      }
      return response;
    } on DioError catch (e) {
      DioExceptions.fromDioError(e);
      final String? error = DioExceptions.message;
      FlashHelper().errorBar(message: error, duration: Duration(seconds: 5));
      print("errorMessage.AuthService: $error");
      log("errorMessage.AuthService: $error");
      return error;
    }
  }

/*  Response handleResponse(Response response) {
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
  }*/
}
