// forget_password_student.dart
import 'package:e_learning/Controllers/auth/celeb_auth_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordCeleb extends StatefulWidget {
  ForgetPasswordCeleb({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordCeleb> createState() => _ForgetPasswordCelebState();
}

class _ForgetPasswordCelebState extends State<ForgetPasswordCeleb> {
  CelebAuthController controller = Get.put(CelebAuthController());

  final TextEditingController mail = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Form(
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
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: CustomTextField(
                controller: mail,
                hintText: 'البريد الالكتروني',
              ),
            ),
            GetBuilder<CelebAuthController>(builder: (controller) {
              if (controller.isLoadingForgetPass) {
                return Container(
                    margin: EdgeInsets.only(top: 25.sp),
                    // ignore: deprecated_member_use
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: GlobalLoading());
              }
              return Container(
                margin: EdgeInsets.only(top: 25.h, right: 60.w, left: 60.w),
                // ignore: deprecated_member_use
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.forgetPasswordCeleb(email: mail.text);
                      }
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
            Form(
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      )),
    );
  }
}
