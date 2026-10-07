import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:e_learning/core/helpers/network_util.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:get/get.dart';

import 'package:e_learning/Widgets/flushbar_helper.dart';
import '../../Models/celebrity/program_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/helpers/helper_dio.dart';

class StudentHomeController extends GetxController {
  final _networkUtil = NetworkUtil();
  RxBool isProgramsLoading = RxBool(false);
  late ProgramModel programModel;
  RxString fullName = RxString('الطالب المميز');
  List<ProgramsData> progData = [];

  @override
  void onInit() {
    getPrograms();
    super.onInit();
  }

  Future<void> getPrograms() async {
    isProgramsLoading.value = true;
    update();

    try {
      final firebaseService = FirebaseService();
      var coursesList = await firebaseService.getCollection('courses');
      if (coursesList.isNotEmpty) {
        progData.clear();
        for (var c in coursesList) {
          progData.add(ProgramsData(
            id: c['id'] is int ? c['id'] : int.tryParse(c['id'].toString()) ?? 1,
            name: c['name'] ?? '',
            image: c['image'] ?? '',
            description: c['description'] ?? '',
          ));
        }
      }

      var currentUser = firebaseService.currentUser;
      if (currentUser != null) {
        var userDoc = await firebaseService.getDocument('users', currentUser.uid);
        if (userDoc == null) {
          userDoc = await firebaseService.getDocument('students', currentUser.uid);
        }
        if (userDoc != null && (userDoc['fullname'] != null || userDoc['name'] != null)) {
          fullName.value = userDoc['fullname'] ?? userDoc['name'];
        } else if (currentUser.displayName != null && currentUser.displayName!.isNotEmpty) {
          fullName.value = currentUser.displayName!;
        } else if (currentUser.email != null) {
          fullName.value = currentUser.email!.split('@')[0];
        }
      } else {
        var usersList = await firebaseService.getCollection('users');
        if (usersList.isNotEmpty) {
          var student = usersList.firstWhere(
            (u) => u['type'] == 'student' || u['fullname'] != null,
            orElse: () => usersList.first,
          );
          if (student['fullname'] != null) {
            fullName.value = student['fullname'];
          } else if (student['name'] != null) {
            fullName.value = student['name'];
          }
        } else {
          fullName.value = "طالب بايزين";
        }
      }
    } catch (e) {
      log("Firebase fetch error in StudentHomeController: $e");
    }

    isProgramsLoading.value = false;
    update();
  }

  String progDialogTitle(int index) {
    if (progData.isNotEmpty && index < progData.length) {
      return progData[index].name ?? "";
    }
    return "";
  }
}
