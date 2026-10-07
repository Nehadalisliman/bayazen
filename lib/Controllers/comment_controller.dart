// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_learning/Models/comment_model.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';

import 'package:e_learning/core/helpers/network_util.dart';
import 'package:e_learning/core/shared_pref.dart';
//import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../core/helpers/helper_dio.dart';

class CommentController extends GetxController {
  final NetworkUtil _networkUtil = NetworkUtil();
  RxInt? index;
  RxBool isGetComment = RxBool(false);
  RxBool isGetNestedComment = RxBool(false);
  RxBool isPostComment = RxBool(false);
  RxBool isPostNestedComment = RxBool(false);

  CommentResponseModel? commentResponseModel;

  // todo  ======== Comments  ==========

  Future<dynamic> getComments({required int video_id}) async {
    isGetComment.value = true;
    try {
      final response = await HelperDio.get(
          endpoint: "comments", data: {"video_id": video_id}, token: userToken);
      if (response.statusCode == 200) {
        print("Comments ${response.data}");

        commentResponseModel = CommentResponseModel.fromJson(response.data);
        isGetComment.value = false;
      }
    } on DioException catch (e) {
      log(e.response?.data);
      isGetComment.value = false;
    }

    // else {
    //   print(response.data);
    //   isGetComment.value = false;
    // }
  }

  // todo  ======== Nested Comments  ==========

  CommentResponseModel? nestedCommentResponseModel;

  Future<dynamic> getNestedComments({required int commentId}) async {
    isGetNestedComment.value = true;
    try {
      final response = await HelperDio.get(
        endpoint: "comments/nested",
        data: {"comment_id": commentId},
        token: userToken,
      );
      if (response.statusCode == 200) {
        print(response.data);
        nestedCommentResponseModel =
            CommentResponseModel.fromJson(jsonDecode(response.toString()));
        isGetNestedComment.value = false;
        nestedCommentResponseModel;
        isGetNestedComment.value = false;
      }
    } on DioException catch (e) {
      print(e.response?.data);
      isGetNestedComment.value = false;
    }
  }

  // todo  ========< Post >Comment  ==========

  Future postComment({String? comment, int? videoId}) async {
    isPostComment.value = true;
    Map<String, dynamic> formData = {
      "video_id": videoId,
      "level": 1,
      "comment": comment,
    };
    final response = await HelperDio.post(
        endpoint: "comments/store", data: formData, token: userToken);

    if (response.statusCode == 200) {
      print(response.data);

      isPostComment.value = false;
      FlashHelper().successBar(message: "تم اضافة التعليق بنجاح");
    } else {
      print(response.data);
      isPostComment.value = false;
    }
  }

  // todo  ======== < Post > Nested Comment  ==========

  Future postNestedComment({
    String? comment,
    int? commentId,
    int? videoId,
  }) async {
    isPostNestedComment.value = true;
    Map<String, dynamic> formData = {
      "video_id": videoId,
      "level": 2,
      "comment": comment,
      "comment_id": commentId
    };
    final response = await HelperDio.post(
        endpoint: "comments/store", data: formData, token: userToken);
    // final response = await _networkUtil
    //     .post("https://bayzin.com/api/comments/store", body: formData);
    // if (response is String) {
    //   if (response.contains('errorMessage.AuthService')) {
    //     String res = response;
    //     String e = "errorMessage.AuthService:";

    //     String error = res.substring(e.length);
    //     isPostNestedComment.value = false;
    //     FlashHelper().errorBar(message: error);
    //     log("error::${error}");
    //     return;
    //   }
    // }

    if (response.statusCode == 200) {
      // isLoading.value = false;
      print(response.data);

      isPostNestedComment.value = false;
      FlashHelper().successBar(message: "تم اضافة التعليق بنجاح");
    } else {
      print(response.data);
      isPostNestedComment.value = false;
    }
  }
}
