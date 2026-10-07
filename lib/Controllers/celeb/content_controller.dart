import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/cele_model.dart';
import '../../Models/content_model.dart';
import '../../Models/home_teacher_response_model.dart';
import '../../Models/magazine_model.dart';
import '../../Models/media_model.dart';
import '../../Screens/celebrity/bottom_nav_bar_screen.dart';
import '../../core/Services/urls.dart';
import '../../Widgets/flushbar_helper.dart';
import '../../core/common/common_ui.dart';
import '../../core/helpers/handel_error.dart';
import '../../core/helpers/helper_dio.dart';
import '../../core/helpers/network_util.dart';

class ContentController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final NetworkUtil _networkUtil = NetworkUtil();
  RxBool isCelLoading = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxBool isImageUpdateLoading = RxBool(false);
  RxBool isVideoUploading = RxBool(false);
  RxBool isUploading = RxBool(false);
  RxDouble uploadVideoValue = RxDouble(0);
  RxString uploadVideoString = RxString('');

  Future<HomeResponseModel?> getHomeContent() async {
    isLoading.value = true;
    try {
      List<Map<String, dynamic>> courses = await _firebaseService.getCollection('courses');
      List<Map<String, dynamic>> videos = await _firebaseService.getCollection('videos');
      List<Map<String, dynamic>> celebs = await _firebaseService.getCollection('celebs');
      isLoading.value = false;
      return HomeResponseModel(
        result: true,
        message: "Success",
        userId: 1,
        firstName: "User",
        image: "",
        accessToken: "",
      );
    } catch (e) {
      isLoading.value = false;
      FlashHelper().errorBar(message: e.toString());
      return null;
    }
  }

  Future<MagazineResponseModel?> getMagazine() async {
    isLoading.value = true;
    try {
      List<Map<String, dynamic>> mags = await _firebaseService.getCollection('magazines');
      isLoading.value = false;
      return MagazineResponseModel(
        result: true,
        message: "Success",
      );
    } catch (e) {
      isLoading.value = false;
      FlashHelper().errorBar(message: e.toString());
      return null;
    }
  }

  Future<ContentResponseModel?> getVideos() async {
    isLoading.value = true;
    try {
      List<Map<String, dynamic>> videoDocs = await _firebaseService.getCollection('videos');
      List<String> videoUrls = videoDocs.map((doc) => doc['url']?.toString() ?? '').toList();
      isLoading.value = false;
      FlashHelper().successBar(message: "تم جلب الفيديوهات بنجاح");
      return ContentResponseModel(
        result: true,
        message: "Success",
        userId: 1,
        videos: videoUrls,
      );
    } catch (e) {
      isLoading.value = false;
      FlashHelper().errorBar(message: e.toString());
      return null;
    }
  }

  Future<MediaResponseModel?> getMediaCele() async {
    try {
      List<Map<String, dynamic>> mediaDocs = await _firebaseService.getCollection('videos');
      return MediaResponseModel(
        result: true,
        message: "Success",
      );
    } catch (e) {
      return null;
    }
  }

  CancelToken cancelToken = CancelToken();
  cancelUpdate() {
    isVideoUploading.value = false;
    isImageUpdateLoading.value = false;
    isUploading.value = false;
    cancelToken.cancel();
  }

  File? myimageFile;
  File? myvideoFile;

  CeleResponseModel? celeResponseModel;
  Future<CeleResponseModel?> getCele() async {
    isCelLoading.value = true;
    try {
      List<Map<String, dynamic>> celebDocs = await _firebaseService.getCollection('celebs');
      List<Cele> celebs = celebDocs.map((doc) => Cele(
        id: doc['id'] ?? 1,
        fullname: doc['fullname'] ?? doc['name'] ?? '',
        image: doc['image'] ?? '',
        spec: doc['spec'] ?? '',
      )).toList();

      isCelLoading.value = false;
      celeResponseModel = CeleResponseModel(
        result: true,
        message: "Success",
        data: celebs,
        userId: "1",
      );
      return celeResponseModel;
    } catch (e) {
      isCelLoading.value = false;
      FlashHelper().errorBar(message: e.toString());
      return null;
    }
  }

  Future<void> fetchImageFromServer(dynamic data) async {}
  Future<void> fetchVideoFromServer(dynamic data) async {}
  Future<void> updateCelebProfile({
    dynamic data,
    dynamic education,
    dynamic experience,
    dynamic spec,
    dynamic skills,
    dynamic interests,
    dynamic image1,
    dynamic video1,
    dynamic image,
    dynamic video,
    dynamic bio,
    dynamic name,
    dynamic personal_vid,
    dynamic context,
  }) async {}
}
