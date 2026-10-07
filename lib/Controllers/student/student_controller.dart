import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:e_learning/Models/current_profile_model.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/core/helpers/network_util.dart';

import '../../core/helpers/helper_dio.dart';

class StudentController extends GetxController {
  final NetworkUtil _networkUtil = NetworkUtil();
  RxBool isLoading = RxBool(false);
  RxBool isProfileLoading = RxBool(false);

  @override
  void onInit() {
    getCurrentStudentProfile();
    super.onInit();
  }

  late UpdateProfileModel profileModel;

  Future<UpdateProfileModel> getCurrentStudentProfile() async {
    isProfileLoading.value = true;
    update();

    try {
      final response = await HelperDio.get(
        endpoint: 'student/profile',
        token: userToken,
      );
      if (response.statusCode == 200 && response.data != null) {
        profileModel = UpdateProfileModel.fromJson(response.data['data']);
        isProfileLoading.value = false;
        update();
        return profileModel;
      }
    } catch (e) {
      log("Profile API error, fetching from Firebase: $e");
    }

    // Fetch real data from Firebase Firestore
    try {
      final firebaseService = FirebaseService();
      var currentUser = firebaseService.currentUser;
      if (currentUser != null) {
        var userDoc = await firebaseService.getDocument('users', currentUser.uid);
        if (userDoc == null) {
          userDoc = await firebaseService.getDocument('students', currentUser.uid);
        }
        if (userDoc != null) {
          profileModel = UpdateProfileModel(
            name: userDoc['fullname'] ?? userDoc['name'] ?? currentUser.displayName ?? "طالب بايزين",
            occupation: userDoc['occupation'] ?? "طالب علم",
            bio: userDoc['bio'] ?? "مهتم بتطوير المهارات والتقنيات.",
            image: userDoc['image'] ?? currentUser.photoURL ?? "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=500",
            email: userDoc['email'] ?? currentUser.email ?? "",
            phone: userDoc['phone'] ?? "",
          );
          isProfileLoading.value = false;
          update();
          return profileModel;
        }
      }

      var usersList = await firebaseService.getCollection('users');
      if (usersList.isNotEmpty) {
        var studentData = usersList.firstWhere(
          (u) => u['type'] == 'student' || u['fullname'] != null,
          orElse: () => usersList.first,
        );
        profileModel = UpdateProfileModel(
          name: studentData['fullname'] ?? studentData['name'] ?? "طالب بايزين",
          occupation: studentData['occupation'] ?? "طالب علم",
          bio: studentData['bio'] ?? "مهتم بتطوير المهارات والتقنيات.",
          image: studentData['image'] ?? "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=500",
          email: studentData['email'] ?? "",
          phone: studentData['phone'] ?? "",
        );
        isProfileLoading.value = false;
        update();
        return profileModel;
      }
    } catch (firebaseErr) {
      log("Firebase profile fetch error: $firebaseErr");
    }

    profileModel = UpdateProfileModel(
      name: "طالب بايزين",
      occupation: "طالب علم وتكنولوجيا",
      bio: "مهتم بالتعلم وتطوير المهارات البرمجية.",
      image: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=500",
      email: "student@bayzin.com",
      phone: "01000000000",
    );
    isProfileLoading.value = false;
    update();
    return profileModel;
  }

  RxBool isProfileUpdateLoading = RxBool(false);
  File? imageFileStudent;

  Future<void> fetchImageFromServer(String image) async {
    String imageUrl = image;
    update();

    try {
      var response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));
      Uint8List bytes = Uint8List.fromList(response.data as List<int>);
      String tempPath = (await getTemporaryDirectory()).path;
      String imagePath = '$tempPath/image.png';
      File imageFile = File(imagePath);
      await imageFile.writeAsBytes(bytes);
      imageFileStudent = imageFile;
      update();
    } catch (e) {
      print('Failed to load image: $e');
      update();
    }
  }

  Future updateStudentProfileImage({
    String? name,
    String? occupation,
    String? email,
    String? bio,
    String? password,
    String? phone,
    String? imageFile,
  }) async {
    isProfileUpdateLoading.value = true;
    var formData2 = FormData.fromMap({
      "fullname": name,
      "occupation": occupation,
      "email": email,
      'image': await MultipartFile.fromFile(imageFile!, filename: 'image.jpg'),
      "bio": bio ?? '',
      "phone": phone,
      "password": password
    });

    try {
      final response = await HelperDio.post(
        endpoint: "student/update/info",
        data: formData2,
        token: userToken,
      );
      if (response.statusCode == 200) {
        log(response.data['message']);
        Get.snackbar(
          'عملية ناجحه',
          response.data['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isProfileLoading.value = false;
      }
    } on DioException catch (e) {
      log(e.response!.data['error']);
      isProfileLoading.value = false;
      Get.snackbar(
        'خطأ',
        e.response!.data['error'],
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
