// forget_password_student.dart

import 'package:e_learning/Controllers/auth/student_auth_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordStudent extends StatelessWidget {
  final TextEditingController mail = TextEditingController();

  ForgetPasswordStudent({Key? key}) : super(key: key);

  StudentAuthController controller = Get.put(StudentAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: ListView(
        children: [
          Image.asset(
            'assets/biz.png',
            height: 210.h,
          ),
          Text(
            'تحقق من رقمك مع الرموز المرسله لك',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: accentColor,
                fontFamily: 'Janna LT Regular',
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
          Form(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: CustomTextField(
                    controller: mail,
                    hintText: 'البريد الالكتروني',
                  ),
                  margin: EdgeInsets.only(top: 20.sp),
                ),
                GetBuilder<StudentAuthController>(builder: (controller) {
                  if (controller.isforgetPassStudentLoading) {
                    return Container(
                        margin: EdgeInsets.only(top: 25.sp),
                        // ignore: deprecated_member_use
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: GlobalLoading());
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 25.sp),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: TextButton(
                        onPressed: () {
                          controller.forgetPasswordStudent(email: mail.text);
                        },
                        child: Text(
                          ' ارسال',
                          style: TextStyle(
                              color: buttonTextColor,
                              fontFamily: 'Janna LT Regular',
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp),
                        )),
                  );
                }),
              ],
            ),
          )
        ],
      )),
    );
  }
}
