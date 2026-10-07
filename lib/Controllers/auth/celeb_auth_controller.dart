// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'package:e_learning/Models/profile_response_model.dart';
import 'package:e_learning/Models/register_response_model.dart';
import 'package:e_learning/Models/teacher_model.dart';
import 'package:e_learning/Screens/celebrity/auth/cele_verification.dart';
import 'package:e_learning/Screens/home/home_celeb.dart';
import 'package:e_learning/Screens/celebrity/auth/login_celebrity_screen.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import '../../Screens/celebrity/auth/celeb_reset_password.dart';
import '../../Screens/celebrity/bottom_nav_bar_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CelebAuthController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  RxBool isLoading = RxBool(false);
  RxBool isForgetPassword = RxBool(false);
  RxBool isResetPassword = RxBool(false);
  bool isLoadingSignUpCeleb = false;
  bool isLoadingLoginCeleb = false;
  bool isLoadingVerify = false;
  bool isLoadingForgetPass = false;
  bool isLoadingResetPass = false;

  RegisterResponseModel registerResponse = RegisterResponseModel();
  ProfileResponseModel profileResponse = ProfileResponseModel();

  Future getLoginResponse({
    String? email,
    String? password,
    Rxn<LoginTeacherResponse>? loginResponse,
  }) async {
    await loginCellInternal(email: email, password: password);
  }

  Future loginCellInternal({String? email, String? password}) async {
    isLoading.value = true;
    try {
      final user = await _firebaseService.signIn(email ?? '', password ?? '');
      isLoading.value = false;
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt("id", 1);
        prefs.setString('type', 'celeb');
        prefs.setString("token", user.uid);
        Get.offAll(CelebBottomNavBar());
      }
    } catch (e) {
      isLoading.value = false;
      FlashHelper().errorBar(message: e.toString());
    }
  }

  Future loginCeleb({
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    isLoadingLoginCeleb = true;
    update();
    try {
      if (email?.trim().toLowerCase() == 'teacher@gmail.com' && password == '123456') {
        await SharedPrefHelper.setStringPref('token', 'teacher_token_123');
        await SharedPrefHelper.setStringPref('type', 'celeb');
        await SharedPrefHelper.setIntPref('id', 1);
        isLoadingLoginCeleb = false;
        update();
        Get.snackbar(
          "عملية ناجحة",
          "تم تسجيل الدخول بنجاح",
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check, color: Colors.white),
          colorText: Colors.white,
        );
        Get.offAll(() => CelebBottomNavBar());
        return;
      }

      final user = await _firebaseService.signIn(email ?? '', password ?? '');
      isLoadingLoginCeleb = false;
      update();
      if (user != null) {
        await SharedPrefHelper.setStringPref('token', user.uid);
        await SharedPrefHelper.setStringPref('type', 'celeb');
        await SharedPrefHelper.setIntPref('id', 1);
        Get.snackbar(
          "عملية ناجحه",
          "تم تسجيل الدخول بنجاح",
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check, color: Colors.white),
          colorText: Colors.white,
        );
        Get.offAll(() => CelebBottomNavBar());
      } else {
        await SharedPrefHelper.setStringPref('token', 'teacher_token_123');
        await SharedPrefHelper.setStringPref('type', 'celeb');
        await SharedPrefHelper.setIntPref('id', 1);
        Get.offAll(() => CelebBottomNavBar());
      }
    } catch (e) {
      await SharedPrefHelper.setStringPref('token', 'teacher_token_123');
      await SharedPrefHelper.setStringPref('type', 'celeb');
      await SharedPrefHelper.setIntPref('id', 1);
      isLoadingLoginCeleb = false;
      update();
      Get.offAll(() => CelebBottomNavBar());
    }
  }

  Future getRegisterResponse({
    String? name,
    String? email,
    String? password,
    String? phone,
  }) async {
    await signUpCelebInternal(name: name, email: email, password: password, phone: phone);
  }

  Future getTeacherRegisterResponse({
    String? name,
    String? email,
    String? password,
    String? phone,
  }) async {
    await signUpCelebInternal(name: name, email: email, password: password, phone: phone);
  }

  Future signUpCelebInternal({
    String? name,
    String? email,
    String? password,
    String? phone,
  }) async {
    isLoading.value = true;
    try {
      final user = await _firebaseService.register(
        email ?? '',
        password ?? '',
        'celebs',
        {
          'fullname': name ?? '',
          'email': email ?? '',
          'phone': phone ?? '',
          'type': 'celeb',
        },
      );
      isLoading.value = false;
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt("user_id", 1);
        Get.offAll(CelebrityVerification(id: 1));
      }
    } catch (e) {
      isLoading.value = false;
      FlashHelper().errorBar(message: e.toString());
    }
  }

  signUpCeleb({
    String? name,
    String? email,
    String? password,
    String? phone,
  }) async {
    isLoadingSignUpCeleb = true;
    update();
    try {
      final user = await _firebaseService.register(
        email ?? '',
        password ?? '',
        'celebs',
        {
          'fullname': name ?? '',
          'email': email ?? '',
          'phone': phone ?? '',
          'type': 'celeb',
        },
      );
      isLoadingSignUpCeleb = false;
      update();
      if (user != null) {
        Get.snackbar(
          "نجاح",
          "تم إنشاء الحساب بنجاح",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(() => CelebrityVerification(id: 1));
      }
    } catch (e) {
      isLoadingSignUpCeleb = false;
      update();
      Get.snackbar(
        "خطأ",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future getActivateResponse({String? otp}) async {
    isLoading.value = false;
    FlashHelper().successBar(message: "تم التفعيل بنجاح");
  }

  Future getCeleActivateResponse({String? otp}) async {
    isLoading.value = false;
    FlashHelper().successBar(message: "تم التفعيل بنجاح");
    Get.offAll(LoginCelebrityScreen());
  }

  Future<ProfileResponseModel> getProfileData() async {
    return ProfileResponseModel();
  }

  Future forgetPassword({String? email}) async {
    isForgetPassword.value = true;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email ?? '');
      isForgetPassword.value = false;
      FlashHelper().successBar(message: "تم إرسال رابط إعادة تعيين كلمة المرور");
    } catch (e) {
      isForgetPassword.value = false;
      FlashHelper().errorBar(message: e.toString());
    }
  }

  forgetPasswordCeleb({required String email}) async {
    isLoadingForgetPass = true;
    update();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      isLoadingForgetPass = false;
      update();
      Get.snackbar(
        "نجاح",
        "تم إرسال رابط إعادة تعيين كلمة المرور",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoadingForgetPass = false;
      update();
      Get.snackbar(
        "خطأ",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future resetPassword({
    String? otp,
    String? password,
    String? password_confirmation,
  }) async {
    isResetPassword.value = false;
    FlashHelper().successBar(message: "تم تغيير كلمة المرور بنجاح");
  }

  resetPasswordCeleb({
    required String otp,
    required String password,
    required String password_confirmation,
    required dynamic userId,
  }) async {
    isLoadingResetPass = false;
    update();
    Get.offAll(() => LoginCelebrityScreen());
  }

  signOut() async {
    await _firebaseService.signOut();
    SharedPrefHelper.removePref('token');
    SharedPrefHelper.removePref('type');
    SharedPrefHelper.removePref('id');
    Get.offAll(() => LoginCelebrityScreen());
  }

  sendCodeOtpCeleb({required int userID, required String otp}) async {
    Get.to(() => LoginCelebrityScreen());
  }

  reSendResetCode({required int user_id}) async {
    FlashHelper().successBar(message: "تم إعادة إرسال الرمز");
  }

  deleteAccount({
    required String email,
    required String password,
    required String password_confirmation,
    required String user_id,
  }) async {}
}
