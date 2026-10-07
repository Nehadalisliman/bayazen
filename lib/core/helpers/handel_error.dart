import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "تم الالغاء";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = "خطأ في الاتصال بالانترنت";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = handleError(dioError.response!.statusCode);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "حدث خطأ غير معروف";
        break;
    }
  }

  static String? message;

  String handleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return 'خطأ بالانترنت';
      case 500:
        return 'Internal server error';
      case 401:
        return 'بريدك الالكتروني او كلمة المرور غير صحيحة';
      default:
        return 'حدث خطأ غير متوقع';
    }
  }
}
