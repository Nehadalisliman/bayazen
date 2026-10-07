import 'dart:convert';
import 'dart:developer';

import 'package:e_learning/Models/category_model.dart';
import 'package:e_learning/Models/course_category_model.dart';
import 'package:e_learning/Screens/CourseWare/category_screen.dart';
import 'package:e_learning/Screens/CourseWare/course_screen.dart';
import 'package:e_learning/Screens/CourseWare/create_course_screen.dart';
import 'package:e_learning/core/Services/urls.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/core/helpers/dio_helper.dart';
import 'package:e_learning/core/helpers/helper_dio.dart';
import 'package:e_learning/core/helpers/network_util.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio_package;

//import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:e_learning/core/helpers/handel_error.dart';

class CourseWareController extends GetxController {
  String? token;
  final NetworkUtil _networkUtil = NetworkUtil();
  RxBool isLoading = RxBool(false);
  //course
  RxBool isCourseDeleted = RxBool(false);
  RxBool isCategoriesLoading = RxBool(false);
  //uploadCourse
  RxBool isUploadCourseLoading = RxBool(false);
  RxDouble uploadValue = RxDouble(0);
  RxString uploadString = RxString('');
  int? id;
  //todo  =========== رفع مناهج تعليميه ================

  RxList<Category> categorys = <Category>[].obs;

  //  todo   ======= get Category =======
  Future<void> getCategories({int? programId}) async {
    isCategoriesLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int id = prefs.getInt('id');
    String? token = prefs.getString('token');
    print('token    $token');
    //  print(id.toString());
    var value = await DioHelper.getData(
        url: "categories", query: {"programId": programId}, token: token);
    //  print("LLLLLLLLLLLLLLLLLLLLLLL" + value.data.toString());
    List<dynamic> data = value.data['categories'];
    print("Here");
    categorys.clear();
    data.forEach(
      (element) {
        categorys.add(Category.fromJson(element));
      },
    );
    isCategoriesLoading.value = false;

    log("libraries$categorys");
  }

  Future getCategoriesCourse({int? programId}) async {
    isCategoriesLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int id = prefs.getInt('id');
    String? token = prefs.getString('token');
    print('token    $token');
    //  print(id.toString());
    var res = await _networkUtil.get(
      "https://bayzin.com/api/categories",
      queryParameters: {"programId": programId},
    );

    if (res is String) {
      isCategoriesLoading.value = false;
      return res;
    }
    if (res == null) {
      isCategoriesLoading.value = false;
      return "No categories";
    }
    List<dynamic> data = res.data['categories'];
    print("Here");
    categorys.clear();
    data.forEach(
      (element) {
        categorys.add(Category.fromJson(element));
      },
    );
    isCategoriesLoading.value = false;

    log("libraries$categorys");
    return true;
  }

  // ================================================

  // todo  ====== createCategory ======
  Future createCategory({String? title, String? description}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("id");
    var token = prefs.getString('token');

    Map<String, dynamic> formData = {
      "user_id": id,
      "access_token": token,
      "title": title,
      "description": description
    };
    final response = await _networkUtil
        .post("${Urls.baseUrl}/createcoursescategory", body: formData);

    if (response.statusCode == 200) {
      isLoading.value = false;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt("category_id", response.data["category_id"]);
      FlashHelper().successBar(message: response.data['message']);
      Get.to(CreateCourse());
    } else {
      isLoading.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }

  CancelToken cancelToken = CancelToken();

  Dio dio = Dio();
  cancelUpload() async {
    isUploadCourseLoading = false.obs;
    uploadValue.value = 0;
    uploadString.value = '0%';
    cancelToken.cancel();
  }

  //  todo  ======  upload Course ======
  Future uploadCourse({
    required PlatformFile file,
    int? programId,
    String? category,
    required BuildContext context,
    String? title,
  }) async {
    uploadValue.value = 0;
    uploadString.value = '0%';
    if (cancelToken.isCancelled) {
      cancelToken = CancelToken();
    }

    dio_package.FormData formData = dio_package.FormData.fromMap({
      "programId": programId.toString(),
      "title": title,
      "category": category,
      "course": await dio_package.MultipartFile.fromFile(file.path!,
          filename: file.path),
    });
    isUploadCourseLoading.value = true;

    try {
      final response = await HelperDio.post(
          endpoint: "course/create", data: formData, token: userToken);
      if (response.statusCode == 200) {
        FlashHelper().successBar(message: response.data['message']);
        isUploadCourseLoading.value = false;
        Navigator.pop(context!);
      }
    } on DioException catch (e) {
      FlashHelper().errorBar(message: e.response?.data['error']);
      isUploadCourseLoading.value = false;
    }
  }

  // ignore: missing_return

  Future editCategory(
      {String? title, String? description, int? category_id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    Map<String, dynamic> formData = {
      "user_id": id,
      "access_token": token,
      "title": title,
      "description": description,
      "category_id": category_id
    };
    final response = await _networkUtil
        .post("${Urls.baseUrl}/modifycoursescategory", body: formData);
    if (response.statusCode == 200) {
      isLoading.value = false;
      print(response.data);
      FlashHelper().successBar(message: response.data['message']);
      Get.offAll(CategoryScreen());
    } else {
      print(response.data);
      isLoading.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }

  Future editCourse({String? title, int? category_id, int? course_id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    Map<String, dynamic> formData = {
      "user_id": id,
      "access_token": token,
      "title": title,
      "course_id": course_id,
      "category_id": category_id
    };
    final response =
        await _networkUtil.post("${Urls.baseUrl}/modifycourse", body: formData);
    if (response.statusCode == 200) {
      isLoading.value = false;
      print(response.data);
      FlashHelper().successBar(message: response.data['message']);
      Get.offAll(CourseScreen());
    } else {
      print(response.data);
      isLoading.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }

  // todo  ========== deleteCourse ==============

  Future deleteCourse({int? course_id}) async {
    isCourseDeleted.value = true;

    final response = await _networkUtil.post(
        "https://bayzin.com/api/course/delete",
        body: {"courseId": course_id});
    log("response $response");

    if (response is String) {
      isCourseDeleted.value = false;
      String su = 'errorMessage.AuthService:';
      String error = response.substring(su.length);
      FlashHelper().errorBar(message: error);
      return;
    }
    if (response.statusCode == 200) {
      isCourseDeleted.value = false;
      print(response.data);
      FlashHelper().successBar(message: response.data['message']);
      return;
    } else {
      print(response.data);
      isCourseDeleted.value = false;
      FlashHelper().errorBar(message: response.data['message']);
      return;
    }
  }

  // ignore: missing_return
  Future<CourseCategoryModel> getCoursescategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    int? category_id = prefs.getInt("category_id");
    Map<String, dynamic> formData = {
      "user_id": id,
      "access_token": token,
      "category_id": category_id
    };
    final response =
        await _networkUtil.post("${Urls.baseUrl}/getcourses", body: formData);
    if (response.statusCode == 200) {
      isLoading.value = false;
      print(response.data);
      FlashHelper().successBar(message: response.data['message']);
      return CourseCategoryModel.fromJson(jsonDecode(response.toString()));
    } else {
      print(response.data);
      isLoading.value = false;
      return await FlashHelper().errorBar(message: response.data['message']);
    }
  }

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
      response = await dio.post(url,
          data: body,
          cancelToken: cancelToken,
          options: Options(
              headers: headers,
              requestEncoder: encoding,
              validateStatus: (status) => status! <= 500),
          onSendProgress: (int sent, int total) {
        var value = (sent / total) * 100;
//uploadVlaue
        log("${value.toInt()}");
        uploadValue.value = value.toInt().toDouble();
        uploadString.value = "${value.toInt()}%";
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
}
