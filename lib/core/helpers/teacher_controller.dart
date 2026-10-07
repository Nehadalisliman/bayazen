/*import 'dart:convert';
import 'dart:io';

import 'package:e_learning/Models/cele_current_profile.dart';
import 'package:e_learning/Models/comment_model.dart';
import 'package:e_learning/Models/file_response_model.dart';
import 'package:e_learning/Models/libraray_model.dart';
import 'package:e_learning/Models/library_video_model.dart';
import 'package:e_learning/Models/video_library.dart';
import 'package:e_learning/Screens/content_screen.dart';
import 'package:e_learning/Screens/library_screen.dart';

import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/helpers/dio_helper.dart';
import 'package:e_learning/helpers/network_util.dart';
import '../Models/celebrity/libraries_model.dart';
import '../Models/celebrity/program_model.dart';
import '../Services/urls.dart';
import 'package:file_picker/file_picker.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart' as dio_package;

class TeacherController extends GetxController {
  final NetworkUtil _networkUtil = NetworkUtil();
  RxInt index;
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    getPrograms();
    getCelebrityProfile();
    getLibrary();
  }

  Future uploadVideo({
    String title,
    File content,
    int programId,
    String description,
    String library_title,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    String token = prefs.getString('token');

    dio_package.FormData formData = dio_package.FormData.fromMap({
      "user_id": id.toString(),
      "title": title,
      "program_id": programId,
      "description": description,
      "content_video": await dio_package.MultipartFile.fromFile(
        content.path,
        //show only filename from path
      ),
      "access_token": token,
      "library": library_title
    });

    final response =
        await _networkUtil.post("${Urls.baseUrl}/video/save", body: formData);

    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      isLoading.value = false;

      print('Thank you');
      print(content.path.toString());
      print('=================================================');
    } else {
      print('error=================================================');
      isLoading.value = false;
    }
  }

  Future uploadMagazine({PlatformFile file}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    String token = prefs.getString('token');
    dio_package.FormData formData = dio_package.FormData.fromMap({
      "user_id": id.toString(),
      "access_token": token,
      "content_file": await dio_package.MultipartFile.fromFile(file.path,
          filename: file.path
          //show only filename from path
          ),
    });

    final response = await _networkUtil.post(
      '${Urls.baseUrl}/savefile',
      body: formData,
    );
    if (response.statusCode == 400) {
      isLoading.value = false;
    }
    if (response.statusCode == 200) {
      return FileResponseModel.fromJson(response.data);
    }
  }

  // ignore: missing_return
  Future<LibraryResponseModel> getVedio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    String token = prefs.getString('token');
    Map<String, dynamic> formData = {"user_id": id, "access_token": token};
    final response =
        await _networkUtil.post("${Urls.baseUrl}/getvideos", body: formData);
    if (response.statusCode == 200) {
      isLoading.value = false;

      return LibraryResponseModel.fromJson(jsonDecode(response.toString()));
    } else {
      print("no");
      isLoading.value = false;
    }
  }

  // ignore: missing_return
  Future<LibraryVideoResponse> getVideosLibrary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    String token = prefs.getString('token');
    int library_id = prefs.getInt("library_id");
    Map<String, dynamic> formData = {
      "user_id": id,
      "access_token": token,
      "library_id": library_id
    };
    final response = await _networkUtil.post("${Urls.baseUrl}/getlibraryvideos",
        body: formData);
    if (response.statusCode == 200) {
      isLoading.value = false;

      // print(response.data["videos"]["id"]);
      return LibraryVideoResponse.fromJson(jsonDecode(response.toString()));
    } else {
      print("no");
      isLoading.value = false;
    }
  }

  // ignore: missing_return
  Future<CommentResponseModel> getComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    String token = prefs.getString('token');
    int video_id = prefs.getInt("video_id");
    Map<String, dynamic> formData = {
      "user_id": id.toString(),
      "access_token": token,
      "video_id": video_id
    };
    final response =
        await _networkUtil.post("${Urls.baseUrl}/getcomments", body: formData);
    if (response.statusCode == 200) {
      isLoading.value = false;
      print(response.data);

      return CommentResponseModel.fromJson(jsonDecode(response.toString()));
    } else {
      print(response.data);
      isLoading.value = false;
    }
  }

  Future postComment({String comment}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    String token = prefs.getString('token');
    int video_id = prefs.getInt("video_id");
    Map<String, dynamic> formData = {
      "user_id": id,
      "access_token": token,
      "video_id": video_id,
      "is_celeb": true,
      "level": 1,
      "level_target_id": null,
      "comment": comment
    };
    final response =
        await _networkUtil.post("${Urls.baseUrl}/postcomment", body: formData);
    if (response.statusCode == 200) {
      isLoading.value = false;
      print(response.data);

      //   return CommentResponseModel.fromJson(jsonDecode(response.toString()));
    } else {
      print(response.data);
      isLoading.value = false;
    }
  }

  CelebrityResponseModel celebrityResponseModel;

  void getCelebrityProfile() async {
    isLoading.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    String token = prefs.getString('token');
    print(id.toString());
    DioHelper.getData(
        url: "/celeb/profile",
        data: {"user_id": id, "access_token": token}).then((value) {
      isLoading.value = true;
      celebrityResponseModel = CelebrityResponseModel.fromJson(value.data);
      print('=============');

      print('=============');
      print(celebrityResponseModel.message);
      print('=============');
      print(celebrityResponseModel.image.toString());
      print('=============');
    }).catchError((error) {
      print('=============');
      print(error.toString());
    });
  }

  // ignore: missing_return
  // Future<CelebrityResponseModel> getCelebrityProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var id = prefs.getInt('id');
  //   var token = prefs.getString('token');
  //
  //   Map<String, dynamic> formData = {
  //     "user_id": id,
  //     "access_token": token,
  //
  //   };
  //
  //   final response = DioHelper.getData()
  //   final response = await _networkUtil.get(
  //     "${Urls.baseUrl}/celeb/profile",
  //     body: formData,
  //   );
  //   if (response.statusCode == 200) {
  //     isLoading.value = false;
  //     return CelebrityResponseModel.fromJson(jsonDecode(response.toString()));
  //   } else {
  //     isLoading.value = false;
  //   }
  // }

  Future createLibraray({String title, String description}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("id");
    var token = prefs.getString('token');

    Map<String, dynamic> formData = {
      "user_id": id,
      "access_token": token,
      "title": title,
      "description": description
    };
    final response =
        await _networkUtil.post("${Urls.baseUrl}/savelibrary", body: formData);

    if (response.statusCode == 200) {
      isLoading.value = false;
      Get.offAll(LibraryScreen());
    } else {
      isLoading.value = false;
    }
  }

  // ignore: missing_return
  Future<LibraryResponse> getLibraries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    var token = prefs.getString('token');

    Map<String, dynamic> formData = {"user_id": id, "access_token": token};
    final response = await _networkUtil.post(
      "${Urls.baseUrl}/getlibraries",
      body: formData,
    );
    if (response.statusCode == 200) {
      isLoading.value = false;
      return LibraryResponse.fromJson(jsonDecode(response.toString()));
    } else {
      isLoading.value = false;
    }
  }

  Future editLibrary({String title, String description, int library_id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    String token = prefs.getString('token');
    Map<String, dynamic> formData = {
      "user_id": id,
      "access_token": token,
      "title": title,
      "description": description,
      "library_id": library_id
    };
    final response = await _networkUtil.post("${Urls.baseUrl}/modifylibrary",
        body: formData);
    if (response.statusCode == 200) {
      isLoading.value = false;
      print(response.data);
      Get.offAll(Content());
    } else {
      print(response.data);
      isLoading.value = false;
    }
  }

  ProgramModel programModel;
  var programsData = <ProgramsData>[].obs;

  Future<void> getPrograms() async {
    isLoading.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int id = prefs.getInt('id');
    String token = prefs.getString('token');
    print('token    $token');
    //  print(id.toString());
    DioHelper.getData(url: "programs", token: token).then((value) {
      isLoading.value = true;
      print(value.data.toString());
      programModel = ProgramModel.fromJson(value.data);
      programsData.addAll(programModel.programs);
    }).catchError((error) {
      print(error.toString());
    });
  }
  LibraryModel libraryModel;
  var libraries = <Libraries>[].obs;
  Future<void> getLibrary() async {
    isLoading.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int id = prefs.getInt('id');
    String token = prefs.getString('token');
    print('token    $token');
    //  print(id.toString());
    DioHelper.getData(url: "libraries", token: token).then((value) {
      isLoading.value = true;
      print(value.data.toString());
      libraryModel = LibraryModel.fromJson(value.data);
      libraries.addAll(libraryModel.libraries);
    }).catchError((error) {
      print(error.toString());
    });
  }



}
*/