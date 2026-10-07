import 'package:e_learning/Controllers/auth/student_auth_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Screens/student/auth/student_login_screen.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Widgets/custom_elevated_button.dart';
import '../../../constants.dart';
import 'student_verification.dart';

class StudentSignUp extends StatelessWidget {
  final RxBool isVisible = RxBool(false);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController mail = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  StudentSignUp({Key? key}) : super(key: key);

  final StudentAuthController controller = Get.put(StudentAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Image.asset(
                  'assets/biz.png',
                  height: 150.h,
                ),
                SizedBox(height: 10.h),
                Text(
                  "إنشاء حساب جديد",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Janna LT Regular',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "سجل بياناتك للبدء في رحلتك التعليمية",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    fontFamily: 'Janna LT Regular',
                  ),
                ),
                SizedBox(height: 24.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        controller: name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'برجاء إدخال الاسم';
                          }
                          return null;
                        },
                        hintText: 'الاسم الكامل',
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        controller: phoneNumber,
                        validator: (String? value) {
                          if (value == null || value.isEmpty || value.length < 10) {
                            return 'برجاء إدخال رقم الهاتف بشكل صحيح';
                          }
                          return null;
                        },
                        hintText: 'رقم الهاتف',
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        controller: mail,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'برجاء إدخال البريد الإلكتروني';
                          }
                          return null;
                        },
                        hintText: 'البريد الإلكتروني',
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
                            if (value == null || value.isEmpty || value.length < 6) {
                              return 'برجاء إدخال كلمة مرور لا تقل عن 6 أحرف';
                            }
                            return null;
                          },
                          hintText: 'كلمة المرور',
                        ),
                      ),
                      SizedBox(height: 24.h),
                      GetBuilder<StudentAuthController>(
                        builder: (controller) {
                          if (controller.isSignUpStudentLoading) {
                            return SizedBox(
                              height: 50.h,
                              width: 50.w,
                              child: const GlobalLoading(),
                            );
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: customElevatedButton(
                              text: 'إنشاء الحساب',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.signUpStudent(
                                    name: name.text.trim(),
                                    email: mail.text.trim(),
                                    password: password.text.trim(),
                                    phone: phoneNumber.text.trim(),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(() => LoginStudent());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'امتلك حساب بالفعل؟ ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                                fontFamily: 'Janna LT Regular',
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'سجل الان',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontFamily: 'Janna LT Regular',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () {
                          Get.to(() => StudentVerification());
                        },
                        child: Text(
                          'امتلك كود بالفعل',
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Janna LT Regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
