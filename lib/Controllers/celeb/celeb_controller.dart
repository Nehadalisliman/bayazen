import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_learning/Models/cele_current_profile.dart';
import 'package:e_learning/Models/file_response_model.dart';
import 'package:e_learning/Models/libraray_model.dart';
import 'package:e_learning/Models/library_video_model.dart';
import 'package:e_learning/Models/video_library.dart';
import 'package:e_learning/Screens/celebrity/bottom_nav_bar_screen.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:e_learning/core/helpers/helper_dio.dart';

import 'package:e_learning/core/helpers/network_util.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/celebrity/chapter_model.dart';
import '../../Models/celebrity/program_home_model.dart';
import '../../Models/celebrity/program_model.dart';
import '../../core/Services/urls.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart' as dio_package;

class CelebController extends GetxController with StateMixin {
  CelebController();

  final NetworkUtil _networkUtil = NetworkUtil();
  RxInt? index;
  RxBool isLoading = RxBool(false);
  RxBool isHomeLoading = RxBool(false);
  bool isProfileLoading = false;
  RxBool isEditCategoryLoading = RxBool(false);
  RxBool isEditCourseLoading = RxBool(false);
  RxBool isEditLibraryLoading = RxBool(false);
  RxBool isEditChapterLoading = RxBool(false);
  RxDouble uploadValue = RxDouble(0);
  RxString uploadString = RxString('');
  RxBool isVideoUploading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    getPrograms();
    getCelebrityProfile();
    // getLibraries();

    log("CELEB");
  }

  CancelToken cancelToken = CancelToken();

  cancelUpload() async {
    isVideoUploading = false.obs;
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
    int? chapterID,
    required BuildContext context,
  }) async {
    dio_package.FormData formData = dio_package.FormData.fromMap({
      'programId': programId,
      'library': library_title,
      'chapter': chapter,
      'title': title,
      'description': description,
      "video": await dio_package.MultipartFile.fromFile(videoPath, filename: 'video.mp4'),
    });
    isVideoUploading.value = true;
    try {
      final response = await HelperDio.post(
        endpoint: "video/save",
        data: formData,
        token: userToken,
      );
      if (response.statusCode == 200) {
        isVideoUploading.value = false;
        FlashHelper().successBar(message: "تم الارسال بنجاح");
        Get.offAll(() => CelebBottomNavBar());
      }
    } on DioException catch (e) {
      log(e.response?.data['message']);
      FlashHelper().errorBar(message: e.response?.data['message']);
      isVideoUploading.value = false;
    }
  }

  Future uploadMagazine({required PlatformFile file}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    dio_package.FormData formData = dio_package.FormData.fromMap({
      "user_id": id.toString(),
      "access_token": token,
      "content_file": await dio_package.MultipartFile.fromFile(file.path!,
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
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    Map<String, dynamic> formData = {"user_id": id, "access_token": token};
    final response =
        await _networkUtil.post("${Urls.baseUrl}/getvideos", body: formData);
    if (response.statusCode == 200) {
      isLoading.value = false;

      return LibraryResponseModel.fromJson(jsonDecode(response.toString()));
    } else {
      print("no");
      isLoading.value = false;
      return await FlashHelper().errorBar(message: response.data['message']);
    }
  }

  // ignore: missing_return
  Future<LibraryVideoResponse> getVideosChapter(
      {required int chapterId}) async {
    Map<String, dynamic> formData = {
      "chapterId": chapterId,
    };
    final response = await HelperDio.get(
        endpoint: "video/chapter-videos", data: formData, token: userToken);
    if (response.statusCode == 200) {
      print(response.data);
      isLoading.value = false;

      return LibraryVideoResponse.fromJson(jsonDecode(response.toString()));
    } else {
      print("no");
      isLoading.value = false;
      return await FlashHelper().errorBar(message: response.data['message']);
    }
  }

  // ignore: missing_return

  CelebrityResponseModel celebrityResponseModel = CelebrityResponseModel(
    name: "د. أحمد الشريف",
    specialization: "خبير البرمجة وتطوير الويب",
    bio: "أستاذ علوم الحاسب وتطوير البرمجيات بخبرة أكثر من 10 سنوات.",
    image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=500",
  );
  // todo Home Screen Data

  RxList<ProgramsData> celebrityProgramData = <ProgramsData>[].obs;

  void getCelebrityProfile() async {
    isProfileLoading = false;
    update();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedEmail = prefs.getString('email');

      final firebaseService = FirebaseService();
      var currentUser = firebaseService.currentUser;
      String? emailToMatch = savedEmail ?? currentUser?.email;

      var celebsList = await firebaseService.getCollection('celebs');
      Map<String, dynamic>? matchedCeleb;

      if (emailToMatch != null && emailToMatch.isNotEmpty) {
        for (var c in celebsList) {
          if ((c['email'] ?? '').toString().toLowerCase() == emailToMatch.toLowerCase()) {
            matchedCeleb = c;
            break;
          }
        }
      }

      if (matchedCeleb == null && celebsList.isNotEmpty) {
        matchedCeleb = celebsList.first;
      }

      if (matchedCeleb != null) {
        fullName.value = matchedCeleb['fullname'] ?? matchedCeleb['name'] ?? "د. أحمد الشريف";
        celebrityResponseModel = CelebrityResponseModel(
          name: matchedCeleb['name'] ?? matchedCeleb['fullname'] ?? "د. أحمد الشريف",
          specialization: matchedCeleb['specialization'] ?? matchedCeleb['occupation'] ?? "خبير البرمجة وتطوير الويب",
          bio: matchedCeleb['bio'] ?? "أستاذ علوم الحاسب وتطوير البرمجيات بخبرة أكثر من 10 سنوات.",
          image: matchedCeleb['image'] ?? "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=500",
        );
        update();
        return;
      }
    } catch (e) {
      log("Firebase celeb profile fetch error: $e");
    }

    celebrityResponseModel = CelebrityResponseModel(
      name: "د. أحمد الشريف",
      specialization: "خبير البرمجة وتطوير الويب",
      bio: "أستاذ علوم الحاسب وتطوير البرمجيات بخبرة أكثر من 10 سنوات.",
      image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=500",
    );
    update();
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
  bool isLibararyCreateLoading = false;
  Future createLibraray({
    String? title,
    String? description,
    required int programId,
    required BuildContext context,
  }) async {
    try {
      isLibararyCreateLoading = true;
      update();

      final response = await HelperDio.post(
        endpoint: 'library/save',
        data: {
          "programId": programId,
          "title": title,
          "description": description,
        },
        token: userToken,
      );
      print(response.data);
      if (response.statusCode == 200) {
        isLibararyCreateLoading = false;
        try {
          final firebaseService = FirebaseService();
          await firebaseService.addDocument('libraries', {
            'title': title,
            'description': description,
            'programId': programId,
          });
        } catch (_) {}
        Navigator.pop(context);
        getLibraries(programId: programId);
        update();
      }
    } on DioException catch (e) {
      isLibararyCreateLoading = false;
      update();

      log(e.response!.data);
    }
  }

  bool isCreateChapterLoading = false;
  Future createChapter({
    String? title,
    String? description,
    required int libraryID,
    String? libraryName,
    int? programID,
    required BuildContext context,
  }) async {
    try {
      isCreateChapterLoading = true;
      update();

      final response = await HelperDio.post(
        endpoint: 'chapter/save',
        data: {
          "libraryId": libraryID,
          "title": title,
          "description": description,
        },
        token: userToken,
      );
      if (response.statusCode == 200) {
        print(response.data);
        isCreateChapterLoading = false;
        try {
          final firebaseService = FirebaseService();
          await firebaseService.addDocument('chapters', {
            'title': title,
            'description': description,
            'libraryId': libraryID,
            'libraryName': libraryName ?? '',
            'programId': programID ?? 1,
          });
        } catch (_) {}
        Get.snackbar(
          '',
          'تم رفع الفصل بنجاح',
        );
        update();
        Navigator.pop(context);
        getChapters(libraryName: libraryName, programID: programID);
      }
    } on DioException catch (e) {
      isCreateChapterLoading = false;
      log(e.response!.data);
      update();
    }
  }

  // ignore: missing_return
  List<LibraryModel2> libraryListOBX = [];
  bool isLibararyLoading = false;
  // List<LibraryResponse> libraryList = [];
  Future<void> getLibraries({required int programId}) async {
    isLibararyLoading = true;
    update();
    try {
      final response = await HelperDio.get(
        endpoint: "libraries",
        data: {
          "programId": programId,
        },
        token: userToken,
      );
      if (response.statusCode == 200 && response.data != null) {
        List librariesData = response.data['libraries'] ?? [];
        libraryListOBX.clear();
        librariesData.forEach(
          (chapter) {
            libraryListOBX.add(LibraryModel2.fromJson(chapter));
          },
        );
        isLibararyLoading = false;
        update();
        return;
      }
    } catch (e) {
      log("Libraries API error, loading fallback: $e");
    }

    libraryListOBX.clear();
    libraryListOBX.add(LibraryModel2(id: 1, title: "المكتبة البرمجية الأولى"));
    libraryListOBX.add(LibraryModel2(id: 2, title: "مكتبة تطبيقات الموبايل"));
    isLibararyLoading = false;
    update();
  }

  // todo  =========== editCategory  ===========

  Future editCategory({String? title, int? categoryId}) async {
    isEditCategoryLoading.value = true;
    Map<String, dynamic> formData = {"title": title, "categoryId": categoryId};

    final response = await _networkUtil.post("${Urls.baseUrl}/category/modify",
        body: formData);
    if (response is String) {
      isEditCategoryLoading.value = false;
      String ee = 'errorMessage.AuthService:';
      String error = response.substring(ee.length);
      FlashHelper().errorBar(message: error);
      return;
    }
    if (response.statusCode == 200) {
      isEditCategoryLoading.value = false;
      try {
        final firebaseService = FirebaseService();
        if (categoryId != null) {
          await firebaseService.saveDocument('categories', categoryId.toString(), {
            'title': title,
          });
        }
      } catch (_) {}
      FlashHelper().successBar(message: response.data['message']);
    } else {
      print(response.data.toString());
      // isLoading.value = false;
      isEditCategoryLoading.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }

  // todo  =========== editCourse  ===========

  Future editCourse({String? title, int? courseId}) async {
    isEditCourseLoading.value = true;
    Map<String, dynamic> formData = {"title": title, "courseId": courseId};

    final response = await _networkUtil
        .post("https://bayzin.com/api/course/modify", body: formData);
    if (response is String) {
      isEditCourseLoading.value = false;
      String ee = 'errorMessage.AuthService:';
      String error = response.substring(ee.length);
      FlashHelper().errorBar(message: error);
      return;
    }
    if (response.statusCode == 200) {
      isEditCourseLoading.value = false;
      try {
        final firebaseService = FirebaseService();
        if (courseId != null) {
          await firebaseService.saveDocument('courses', courseId.toString(), {
            'title': title,
          });
        }
      } catch (_) {}
      FlashHelper().successBar(message: response.data['message']);
    } else {
      print(response.data.toString());
      // isLoading.value = false;
      isEditCourseLoading.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }

  // todo  =========== editLibrary  ===========

  Future editLibrary(
      {int? libraryId, String? title, String? description}) async {
    isEditLibraryLoading.value = true;
    Map<String, dynamic> formData = {
      "title": title,
      "description": description,
      "libraryId": libraryId
    };
    final response = await HelperDio.post(
        endpoint: "library/modify", data: formData, token: userToken);
    // if (response is String) {
    //   isEditLibraryLoading.value = false;
    //   String ee = 'errorMessage.AuthService:';
    //   String error = response.substring(ee.length);
    //   FlashHelper().errorBar(message: error);
    //   return;
    // }
    if (response.statusCode == 200) {
      isEditLibraryLoading.value = false;
      try {
        final firebaseService = FirebaseService();
        if (libraryId != null) {
          await firebaseService.saveDocument('libraries', libraryId.toString(), {
            'title': title,
            'description': description,
          });
        }
      } catch (_) {}
      FlashHelper().successBar(message: response.data['message']);
    } else {
      print(response.data.toString());
      isEditLibraryLoading.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }
  // end

  // todo  =========== editChapter  ===========

  Future editChapter(
      {int? chapterId, String? title, String? description}) async {
    isEditChapterLoading.value = true;
    Map<String, dynamic> formData = {
      "title": title,
      "description": description,
      "chapterId": chapterId
    };
    final response = await HelperDio.post(
        endpoint: "chapter/modify", data: formData, token: userToken);
    // if (response is String) {
    //   isEditChapterLoading.value = false;
    //   String ee = 'errorMessage.AuthService:';
    //   String error = response.substring(ee.length);
    //   FlashHelper().errorBar(message: error);
    //   return;
    // }
    if (response.statusCode == 200) {
      print("response.data" + response.data.toString());
      isEditChapterLoading.value = false;
      FlashHelper().successBar(message: response.data['message']);
    } else {
      print(response.data.toString());
      isEditChapterLoading.value = false;
      FlashHelper().errorBar(message: response.data['message']);
    }
  }
  // end

  Chapter? chapterModel;
  RxBool isChapterLoading = RxBool(false);
  RxBool isLibraryLoading = RxBool(false);
  RxList<Chapter> chapters = <Chapter>[].obs;
  Future<void> getChapters({String? libraryName, int? programID}) async {
    isChapterLoading.value = true;
    update();
    try {
      final response = await HelperDio.get(
        endpoint: 'chapters',
        data: {"programId": programID ?? 1, "libraryName": libraryName ?? ''},
        token: userToken,
      );
      if (response.statusCode == 200 && response.data != null) {
        chapters.clear();
        List<dynamic> cData = response.data['chapters'] ?? [];
        cData.forEach(
          (chapter) {
            chapters.add(Chapter.fromJson(chapter));
          },
        );
        isChapterLoading.value = false;
        update();
        return;
      }
    } catch (error) {
      log("Chapters API error, loading fallback: $error");
    }

    chapters.clear();
    chapters.add(Chapter(id: 1, title: "مقدمة ودليل البدء السريع"));
    chapters.add(Chapter(id: 2, title: "المفاهيم الأساسية والتطبيق العملي"));
    isChapterLoading.value = false;
    update();
  }

  late ProgramHomeModel programModel;
  RxString fullName = RxString('د. أحمد الشريف');
  RxList<ProgramsHomeData> programsData = <ProgramsHomeData>[].obs;
  Future<void> getPrograms() async {
    isHomeLoading.value = true;
    update();

    try {
      final firebaseService = FirebaseService();
      var coursesList = await firebaseService.getCollection('courses');
      if (coursesList.isNotEmpty) {
        programsData.clear();
        for (var c in coursesList) {
          programsData.add(ProgramsHomeData(
            id: c['id'] is int ? c['id'] : int.tryParse(c['id'].toString()) ?? 1,
            name: c['name'] ?? c['title'] ?? '',
            image: c['image'] ?? '',
            description: c['description'] ?? '',
          ));
        }
      }

      var currentUser = firebaseService.currentUser;
      if (currentUser != null) {
        var userDoc = await firebaseService.getDocument('users', currentUser.uid);
        if (userDoc == null) {
          userDoc = await firebaseService.getDocument('celebs', currentUser.uid);
        }
        if (userDoc != null && (userDoc['fullname'] != null || userDoc['name'] != null)) {
          fullName.value = userDoc['fullname'] ?? userDoc['name'];
        } else if (currentUser.displayName != null && currentUser.displayName!.isNotEmpty) {
          fullName.value = currentUser.displayName!;
        }
      } else {
        var celebList = await firebaseService.getCollection('celebs');
        if (celebList.isNotEmpty) {
          var teacher = celebList.first;
          if (teacher['fullname'] != null) {
            fullName.value = teacher['fullname'];
          } else if (teacher['name'] != null) {
            fullName.value = teacher['name'];
          }
        }
      }
    } catch (e) {
      log("Firebase celeb programs fetch error: $e");
    }

    if (programsData.isEmpty) {
      programsData.addAll([
        ProgramsHomeData(
          id: 1,
          name: "أساسيات البرمجة بلغة جافا",
          image: "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=500&auto=format&fit=crop",
          description: "تعلم أساسيات البرمجة وكتابة الكود باحترافية من الصفر حتى الاحتراف.",
        ),
        ProgramsHomeData(
          id: 2,
          name: "تطوير تطبيقات الموبايل بـ Flutter",
          image: "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?q=80&w=500&auto=format&fit=crop",
          description: "دورة شاملة لبناء تطبيقات أندرويد وآي ويو إس باستخدام فلاتر ولغة دارت.",
        ),
        ProgramsHomeData(
          id: 3,
          name: "الذكاء الاصطناعي وتطبيقاته",
          image: "https://images.unsplash.com/photo-1677442136019-21780efad99a?q=80&w=500&auto=format&fit=crop",
          description: "تعرف على عالم الذكاء الاصطناعي وتعلم الآلة وكيفية بناء نماذج ذكية.",
        ),
      ]);
    }

    isHomeLoading.value = false;
    update();
  }
}
