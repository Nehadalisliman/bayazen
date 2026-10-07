import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/core/Services/urls.dart';
import 'package:e_learning/core/helpers/handel_error.dart';
import 'package:e_learning/core/helpers/helper_dio.dart';
import 'package:e_learning/core/helpers/network_util.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryController extends GetxController {
  final NetworkUtil _networkUtil = NetworkUtil();
  // ? ======== VIDEO ======= //
  RxString uploadString = RxString('');
  RxBool isVideoUploading = RxBool(false);
  RxDouble uploadValue = RxDouble(0);
  // ? ======== VIDEO ======= //
  RxBool isImagesUploading = RxBool(false);
  RxString uploadImagesString = RxString('');
  RxDouble uploadImagesValue = RxDouble(0);

  // ? ======== Delete ======= //
  RxBool isDeletePost = RxBool(false);

  // ? ======== Edit ======= //
  RxBool isEditPost = RxBool(false);

  CancelToken cancelToken = CancelToken();

  CancelToken cancelTokenImages = CancelToken();

  Dio dio = Dio();
  cancelUpload() async {
    isVideoUploading = false.obs;
    uploadValue.value = 0;
    uploadString.value = '0%';

    cancelToken.cancel();
  }

  cancleUpladImagesFunc() {
    uploadImagesString.value = '0%';
    uploadImagesValue.value = 0;
    isImagesUploading = false.obs;

    cancelTokenImages.cancel();
  }

  Future<dynamic> post(String url,
      {dynamic body, encoding, String? token}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // int? id = prefs.getInt('id');
    // String? token = prefs.getString('token');
    // var headers = {
    //   'X-Requested-With': 'XMLHttpRequest',
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $token'
    // };
    if (cancelToken.isCancelled) {
      cancelToken = CancelToken();
    }
    var response;
    try {
      response = await dio.post(url,
          data: body,
          cancelToken: cancelToken,
          options: Options(headers: {"authorization": 'Bearer $token'}),
          queryParameters: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          }, onSendProgress: (int sent, int total) {
        var value = (sent / total) * 100;
//uploadVlaue
        log("${value.toInt()}");
        uploadValue.value = value.toInt().toDouble();
        uploadString.value = "${value.toInt()}%";
      });
      print("response$response");

      return response;
    } on DioException catch (e) {
      print(e.response?.data);
    }
  }

  Future<dynamic> postImages(String url, {dynamic body, encoding}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    var headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    if (cancelTokenImages.isCancelled) {
      cancelTokenImages = CancelToken();
    }
    var response;
    try {
      response = await dio.post(url,
          data: body,
          cancelToken: cancelTokenImages,
          options: Options(
              headers: headers,
              requestEncoder: encoding,
              validateStatus: (status) => status! <= 500),
          onSendProgress: (int sent, int total) {
        var value = (sent / total) * 100;
//uploadVlaue
        log("${value.toInt()}");
        uploadImagesValue.value = value.toInt().toDouble();
        uploadImagesString.value = "${value.toInt()}%";
      });
      print("response$response");

      return response;
    } on DioException catch (e) {
      DioExceptions.fromDioError(e);
      final String? error = DioExceptions.message;
      print("errorMessage.AuthService: $error");
      log("errorMessage.AuthService: $error");
    }
  }

  Future uploadVideo({
    required String videoPath,
    String? description,
  }) async {
    isVideoUploading.value = true;
    uploadValue.value = 0;
    uploadString.value = '0%';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    var headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    dio_package.FormData formData = dio_package.FormData.fromMap({
      "description": description,
      "video": await dio_package.MultipartFile.fromFile(
        videoPath,
      ),
    });

    final response = await post(
      "stories/create",
      body: formData,
      // headers: headers,
      token: userToken,
      // data: formData,
    );
    print(response.data);
    // if (response is String) {
    //   String d = "errorMessage.AuthService: ";
    //   String e = response.substring(d.length);
    //   isVideoUploading.value = false;
    //   FlashHelper().errorBar(messag  e: e);
    //   return;
    // }
    isVideoUploading.value = false;
    FlashHelper().successBar(message: response.data['message']);
    return "Ok";
  }

  // TODO +++++++++++ IMAGES +++++++++++++++
  Future uploadStory({
    required String videoPath,
    required List<XFile> images,
    String? description,
  }) async {
    isVideoUploading.value = true;
    uploadValue.value = 0;
    uploadString.value = '0%';

    FormData formData = FormData.fromMap({
      "description": description,
      "images[]": [
        for (var item in images)
          {
            await dio_package.MultipartFile.fromFile(item.path,
                filename: item.path.split('/').last)
          }.toList()
      ],
      "video": await dio_package.MultipartFile.fromFile(
        videoPath,
      ),
    });

    try {
      final response = await HelperDio.post(
        endpoint: "stories/create",
        data: formData,
        token: userToken,
      );
      if (response.statusCode == 200) {
        print(response.data);
        FlashHelper().successBar(message: response.data['message']);
      }
      isVideoUploading.value = false;
    } on DioException catch (e) {
      print(e.response?.data);
      Get.snackbar(
        "خطأ",
        e.response!.data['error'],
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
        colorText: Colors.white,
      );

      isVideoUploading.value = false;
    }
  }

  Future uploadImages({
    required List<XFile> images,
    String? description,
  }) async {
    isImagesUploading.value = true;
    uploadImagesValue.value = 0;
    uploadImagesString.value = '0%';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    var headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var data = {
      "description": description,
      "images": [
        for (var item in images)
          {
            await dio_package.MultipartFile.fromFile(item.path,
                filename: item.path.split('/').last)
          }.toList()
      ],
    };

    dio_package.FormData formData = dio_package.FormData.fromMap({
      "description": description,
      "images": [
        for (var item in images)
          {
            await dio_package.MultipartFile.fromFile(item.path,
                filename: item.path.split('/').last)
          }.toList()
      ],
    });

    final response = await HelperDio.post(
        endpoint: "stories/create", token: userToken, data: formData);

    // if (response is String) {
    //   String d = "errorMessage.AuthService: ";
    //   String e = response.substring(d.length);
    //   isImagesUploading.value = false;
    //   FlashHelper().errorBar(message: e);
    //   return;
    // }
    isImagesUploading.value = false;
    FlashHelper().successBar(message: response.data['message']);
    return "Ok";
  }

  // TODO =========== Delete Post =============

  Future deletePost({
    int? storyId,
  }) async {
    isDeletePost.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    var headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var data = {
      "storyId": storyId,
    };

    final response = await post("${Urls.baseUrl}stories/delete",
        // headers: headers,
        body: data);

    if (response is String) {
      String d = "errorMessage.AuthService: ";
      String e = response.substring(d.length);
      isDeletePost.value = false;
      FlashHelper().errorBar(message: e);
      return;
    }
    isDeletePost.value = false;
    FlashHelper().successBar(message: response.data['message']);
    return "Ok";
  }

  // todo  =========== editStory  ===========

  Future editStory({String? description, int? storyId}) async {
    isEditPost.value = true;
    Map<String, dynamic> formData = {
      "storyId": storyId,
      "description": description
    };

    final response = await _networkUtil.post("${Urls.baseUrl}stories/modify",
        body: formData);
    if (response is String) {
      isEditPost.value = false;
      String ee = 'errorMessage.AuthService:';
      String error = response.substring(ee.length);
      FlashHelper().errorBar(message: error);
      return;
    }
    if (response.statusCode == 200) {
      print("response.data" + response.data.toString());
      isEditPost.value = false;
      FlashHelper().successBar(message: response.data['message']);
    } else {
      print(response.data.toString());
      isEditPost.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }
}
