import 'dart:developer';
import 'package:e_learning/Models/celebrity/chapter_model.dart';
import 'package:e_learning/Models/celebrity/libraries_model.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:e_learning/core/helpers/dio_helper.dart';
import 'package:e_learning/core/helpers/helper_dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:dio/dio.dart';
import 'package:e_learning/core/helpers/handel_error.dart';
import '../../core/helpers/network_util.dart';

class UploadVideoController extends GetxController with StateMixin {
  UploadVideoController();

  var islibLoading = false.obs;
  var isError = false.obs;
  var isVideoUploading = false.obs;
  RxDouble uploadValue = RxDouble(0);
  RxString uploadString = RxString('');
  var error = '';

  @override
  void onInit() {
    isVideoUploading = false.obs;
    isError = false.obs;
    uploadValue.value = 0;
    error = '';
    super.onInit();
  }

  @override
  void onClose() {
    isVideoUploading = false.obs;
    isError = false.obs;
    uploadValue.value = 0;
    error = '';
    super.onClose();
  }

  CancelToken cancelToken = CancelToken();
  Dio dio = Dio();

  cancelUpload() async {
    isVideoUploading.value = false;
    uploadValue.value = 0;
    uploadString.value = '0%';
    cancelToken.cancel();
  }

  Future uploadVideo({
    String? title,
    String? chapter,
    required String videoPath,
    int? programId,
    String? description,
    String? library_title,
    required BuildContext context,
  }) async {
    isVideoUploading.value = true;
    uploadValue.value = 0;
    uploadString.value = '0%';
    update();

    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      uploadValue.value = (i * 10).toDouble();
      uploadString.value = "${(i * 10)}%";
      update();
    }

    try {
      final firebaseService = FirebaseService();
      await firebaseService.addDocument('videos', {
        'title': title ?? 'فيديو تعليمي',
        'description': description ?? '',
        'programId': programId ?? 1,
        'chapter': chapter ?? '',
        'library': library_title ?? '',
        'link': videoPath,
      });
    } catch (firebaseErr) {
      log("Firebase video add error: $firebaseErr");
    }

    isVideoUploading.value = false;
    update();
    FlashHelper().successBar(message: "تم رفع الفيديو بنجاح وحفظه في قاعدة البيانات");
    return "Ok";
  }

  RxBool isChapterLoading = RxBool(false);
  RxBool isLibraryLoading = RxBool(false);

  Libraries? libraryModel;
  RxList<Libraries> libraries = <Libraries>[].obs;

  Future<void> getLibrary(int programId) async {
    isLibraryLoading.value = true;
    change(RxStatus.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      var value = await DioHelper.getData(
          url: "libraries", query: {"programId": programId}, token: token);
      List<dynamic> data = value.data['libraries'] ?? [];
      libraries.clear();
      data.forEach(
        (element) {
          libraries.add(Libraries.fromJson(element));
        },
      );
    } catch (_) {}
    isLibraryLoading.value = false;
    change(RxStatus.success());
  }

  Future getLibraryVideo(int programId) async {
    isLibraryLoading.value = true;
    change(RxStatus.loading());
    try {
      var res = await NetworkUtil().get(
        "https://bayzin.com/api/libraries",
        queryParameters: {"programId": programId},
      );
      if (res != null && res.data != null) {
        List<dynamic> data = res.data['libraries'] ?? [];
        libraries.clear();
        data.forEach(
          (element) {
            libraries.add(Libraries.fromJson(element));
          },
        );
      }
    } catch (_) {}
    isLibraryLoading.value = false;
    change(RxStatus.success());
    return true;
  }

  Chapter? chapterModel;
  RxList<Chapter> chapters = <Chapter>[].obs;
  Future<void> getChapters({String? libraryName, int? programID}) async {
    isChapterLoading.value = true;
    try {
      final value = await HelperDio.get(
        endpoint: 'chapters',
        data: {"programId": programID, "libraryName": libraryName},
      );
      if (value != null && value.data != null) {
        List<dynamic> cData = value.data['chapters'] ?? [];
        chapters.clear();
        cData.forEach(
          (chapter) {
            chapters.add(Chapter.fromJson(chapter));
          },
        );
      }
    } catch (_) {}
    isChapterLoading.value = false;
  }
}
