import 'package:e_learning/Controllers/auth/celeb_auth_controller.dart';
import 'package:e_learning/Controllers/browsing_controller.dart';
import 'package:e_learning/Controllers/auth/student_auth_controller.dart';
import 'package:e_learning/Controllers/student/student_home_controller.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Controllers/celeb/upload_video_controller.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseService());
    Get.lazyPut(() => CelebAuthController());
    Get.lazyPut(() => CelebController());
    Get.lazyPut(() => UploadVideoController());
    Get.lazyPut(() => BrowsingController());
    //StudentAuthController
    Get.lazyPut(() => StudentAuthController());
    //StudentHomeController
    Get.lazyPut(() => StudentHomeController());
  }
}
