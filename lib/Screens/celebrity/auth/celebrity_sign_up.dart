import 'package:e_learning/Controllers/auth/celeb_auth_controller.dart';
import 'package:e_learning/Screens/celebrity/auth/login_celebrity_screen.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'cele_verification.dart';

class CelebritySignUp extends GetView<CelebAuthController> {
  final RxBool isVisible = RxBool(false);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController mail = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  CelebritySignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Image.asset(
                'assets/biz.png',
                height: 180.h,
              ),
              CustomTextField(
                controller: name,
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return;
                  }
                  return null;
                },
                hintText: 'الاسم',
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextField(
                controller: mail,
                validator: (String? value) {
                  if (value!.isEmpty ||
                      !RegExp(r"[a-z0-9!#$%&'*+/=^_`{|}~-]+(:\.[a-z0-9!#$%&'*+/=^_`{|}~-]+)*@(:[a-z0-9](:[a-z0-9-]*[a-z0-9])\.)+[a-z0-9](:[a-z0-9-]*[a-z0-9])")
                          .hasMatch(value)) {
                    return;
                  }
                  return null;
                },
                hintText: 'البريد الالكتروني',
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextField(
                controller: password,
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return;
                  }
                  return null;
                },
                hintText: 'الرقم السري',
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextField(
                controller: phoneNumber,
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return;
                  }
                  return null;
                },
                hintText: ' رقم الهاتف',
              ),
              SizedBox(
                height: 25.h,
              ),
              GetBuilder<CelebAuthController>(
                init: CelebAuthController(),
                builder: (controller) {
                  return controller.isLoadingSignUpCeleb
                      ? Container(
                          height: 70,
                          width: 60,
                          child: const GlobalLoading(),
                        )
                      : customElevatedButton(
                          text: 'تسجيل الدخول',
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              controller.signUpCeleb(
                                  name: name.text,
                                  email: mail.text,
                                  password: password.text,
                                  phone: phoneNumber.text);
                            }
                          },
                        );
                },
              ),
              SizedBox(height: 15.h),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(LoginCelebrityScreen());
                  },
                  child: const Text.rich(TextSpan(
                      text: 'امتلك حساب بالفعل! ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'سجل الان',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: primaryColor),
                        )
                      ])),
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       Get.to(CelebrityVerification());
              //     },
              //     child: Text('امتلك كود بالفعل',
              //         style: TextStyle(
              //             color: primaryColor,
              //             fontFamily: 'Janna LT Regular',
              //             fontWeight: FontWeight.bold,
              //             fontSize: 12))),
            ],
          ),
        ),
      ),
    );
  }
}
