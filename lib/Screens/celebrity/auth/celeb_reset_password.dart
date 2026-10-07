// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:e_learning/Controllers/auth/celeb_auth_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Screens/student/auth/student_sign_up_screen.dart';

import '/constants.dart';

// ignore: must_be_immutable
class CelebResetPassword extends StatelessWidget {
  final dynamic id;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();

  // OtpFieldController codeController = OtpFieldController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  CelebResetPassword({
    Key? key,
    this.id,
  }) : super(key: key);

  CelebAuthController controller = Get.put(CelebAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
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
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: TextField(
                controller: codeController,
                decoration: InputDecoration(
                  hintText: 'كود التحقق',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Janna LT Regular',
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'كلمة المرور',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Janna LT Regular',
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: TextField(
                controller: conPasswordController,
                decoration: InputDecoration(
                  hintText: 'تاكيد كلمة المرور',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Janna LT Regular',
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            // Center(
            //   child: InkWell(
            //     onTap: () {
            //       controller.reSendResetCode(user_id: int.parse(id));
            //     },
            //     child: const Text.rich(TextSpan(
            //         text: 'لم اتلق الرمز',
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //         children: <InlineSpan>[
            //           TextSpan(
            //             text: '  اعادة الارسال',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold, color: primaryColor),
            //           )
            //         ])),
            //   ),
            // ),
            GetBuilder<CelebAuthController>(builder: (controller) {
              if (controller.isLoadingResetPass) {
                return Container(
                    margin: EdgeInsets.only(top: 25.sp),
                    child: GlobalLoading());
              }

              return Container(
                width: 180.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: primaryColor),
                margin: EdgeInsets.only(top: 25.h, right: 40.w, left: 40.w),
                child: TextButton(
                    onPressed: () async {
                      controller.resetPasswordCeleb(
                        otp: codeController.text,
                        password: passwordController.text,
                        password_confirmation: conPasswordController.text,
                        userId: id!,
                      );
                    },
                    child: Text(
                      ' تاكيد',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Janna LT Regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
                    )),
              );
            }),
          ],
        ),
      ),
    );
  }
}
