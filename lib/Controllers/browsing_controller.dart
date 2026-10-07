import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_learning/Models/cele_current_profile.dart';
import 'package:e_learning/Models/course/course_browsing.dart';
import 'package:e_learning/Models/video/video_browsing.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/core/helpers/network_util.dart';
import '../Models/celebrity/program_model.dart';
import 'package:get/get.dart';

import '../core/helpers/helper_dio.dart';
import '../core/shared_pref.dart';

class BrowsingController extends GetxController with StateMixin {
  final NetworkUtil _networkUtil = NetworkUtil();
  RxInt? index;
  RxBool isLoading = RxBool(false);
  RxBool isProfileLoading = RxBool(false);
  RxBool isVideoLoading = RxBool(false);
  RxBool isCourseLoading = RxBool(false);

  CelebrityResponseModel? celebrityResponseModel;
  // todo Home Screen Data

  RxList<ProgramsData> celebrityProgramData = <ProgramsData>[].obs;

  void getCelebProfile({int? celebId}) async {
    isProfileLoading.value = true;
    try {
      var response = await HelperDio.get(
        endpoint: 'browse/celeb',
        data: {"celebId": celebId},
        token: userToken,
      );
      if (response.statusCode == 200) {
        log("responseClebbb ${response.data}");
        celebrityProgramData.clear();
        celebrityResponseModel = CelebrityResponseModel.fromJson(response.data);
        print('celebrityResponseModel');
        log("celebrityResponseModel ${celebrityResponseModel!.experience.toString()}");
        List<dynamic> programsDataaaa = response.data['programs'];
        programsDataaaa.forEach((prog) {
          celebrityProgramData.add(ProgramsData.fromJson(prog));
        });
        isProfileLoading.value = false;

        print(celebrityResponseModel!.image.toString());
        // FlashHelper().successBar(message: response.data['message']);
      }
    } on DioException catch (e) {
      print(e.response?.data);
      //isProfileLoading.value = false;
      FlashHelper().errorBar(message: e.response?.data);
    }
  }

  // todo  ====== Video Browsing  ======
  late VideoBrwosing videoBrwosing;

  void getCelebVideoBrowsing({
    required int chapterId,
    required int celebId,
  }) async {
    isVideoLoading.value = true;

    final response = await HelperDio.get(
        endpoint: "browse/videos",
        data: {
          "chapterId": chapterId,
          "celebId": celebId,
        },
        token: userToken);
    log("RES ${response.data}");

    // if (response is String) {
    //   isVideoLoading.value = false;
    //   String ee = 'errorMessage.AuthService:';
    //   String error = response.substring(ee.length);
    //   FlashHelper().errorBar(message: error);
    //   return;
    // }
    if (response.statusCode == 200) {
      log("videoBrwosing ${response.data}");
      videoBrwosing = VideoBrwosing.fromJson(response.data['videos']);
      log("videoBrwosing ${videoBrwosing.link.toString()}");
      print('Value.Data');
      isVideoLoading.value = false;
    } else {
      print(response.data.toString());
      isVideoLoading.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }

  // todo  ====== Course Browsing  ======
  late CourseBrowsing courseBrowsing;

  void getCelebCourseBrowsing({
    required int courseId,
    required int categoryId,
  }) async {
    isCourseLoading.value = true;

    final response = await HelperDio.get(
        endpoint: "courses",
        data: {
          "courseId": courseId,
          "categoryId": categoryId,
        },
        token: userToken);
    // if (response is String) {
    //   isCourseLoading.value = false;
    //   String ee = 'errorMessage.AuthService:';
    //   String error = response.substring(ee.length);
    //   FlashHelper().errorBar(message: error);
    //   return;
    // }
    if (response.statusCode == 200) {
      // log("courseBrowsing ${response.data}");

      courseBrowsing = CourseBrowsing.fromJson(response.data);
      isCourseLoading.value = false;
    } else {
      print(response.data.toString());
      isCourseLoading.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }
}
