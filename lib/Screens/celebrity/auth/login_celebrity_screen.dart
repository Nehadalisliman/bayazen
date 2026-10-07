import 'package:e_learning/Controllers/auth/celeb_auth_controller.dart';
import 'package:e_learning/Screens/celebrity/auth/celebrity_sign_up.dart';
import 'package:e_learning/Screens/celebrity/auth/forget_password_screen.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/Widgets/custom_back_button.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginCelebrityScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxBool isVisible = RxBool(false);
  final TextEditingController mail = TextEditingController();
  final TextEditingController password = TextEditingController();
  final CelebAuthController controller = Get.put(CelebAuthController());

  LoginCelebrityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: CustomBackButton(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Container(
                constraints: BoxConstraints(maxWidth: 400.w),
                padding: EdgeInsets.all(22.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/biz.png',
                        height: 100.h,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "مرحباً بك يا معلم",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: 'Janna LT Regular',
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "تسجيل الدخول للوحة تحكم المعلمين",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey.shade500,
                          fontFamily: 'Janna LT Regular',
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'برجاء ادخال البريد الالكتروني';
                          }
                          return null;
                        },
                        controller: mail,
                        hintText: 'البريد الالكتروني',
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => CustomTextField(
                          maxLines: 1,
                          secureText: isVisible.value ? false : true,
                          suffixIcon: InkWell(
                            onTap: () {
                              isVisible.value = !isVisible.value;
                            },
                            child: Icon(
                              isVisible.value == true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 21.sp,
                              color: Colors.grey,
                            ),
                          ),
                          controller: password,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'برجاء ادخال الباسورد';
                            }
                            return null;
                          },
                          hintText: 'الباسورد',
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ForgetPasswordCeleb());
                          },
                          child: Text(
                            'نسيت الباسورد؟',
                            style: TextStyle(
                              fontFamily: 'Janna LT Regular',
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      GetBuilder<CelebAuthController>(
                        builder: (controller) {
                          if (controller.isLoadingLoginCeleb) {
                            return SizedBox(
                              height: 46.h,
                              width: 46.w,
                              child: const GlobalLoading(),
                            );
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: 46.h,
                            child: customElevatedButton(
                              onPressed: () {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  controller.loginCeleb(
                                    email: mail.text,
                                    password: password.text,
                                    context: context,
                                  );
                                }
                              },
                              text: 'تسجيل الدخول',
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(() => CelebritySignUp());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'لا تمتلك حساب؟ ',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'انشاء حساب',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
