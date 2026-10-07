// ignore_for_file: public_member_api_docs, sort_constructors_first
// student_verification.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:e_learning/Controllers/auth/student_auth_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';

import '../../../constants.dart';

class StudentVerification extends GetView<StudentAuthController> {
  final int? id;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  StudentVerification({
    this.id,
  });

  OtpFieldController optController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Image.asset(
              'assets/biz.png',
              height: 210.h,
            ),
            const Text(
              'تحقق من رقمك مع الرموز المرسله لك',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: accentColor,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.h,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OTPTextField(
                        length: 4,
                        controller: optController,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 35.h,
                        style: TextStyle(fontSize: 17.sp, color: Colors.white),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.box,
                        otpFieldStyle: OtpFieldStyle(
                          backgroundColor: primaryColor,
                          borderColor: primaryColor,
                        ),
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                        },
                        onChanged: (value) {
                          print(value);
                          codeController.text = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        controller.reSendResetCodeStudent(user_id: id!);
                      },
                      child: const Text.rich(TextSpan(
                          text: 'لم اتلق الرمز',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '  اعادة الارسال',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            )
                          ])),
                    ),
                  ),
                  GetBuilder<StudentAuthController>(
                    builder: (controller) {
                      if (controller.isResendCodeLoading) {
                        return Container(
                            height: 50.h,
                            width: 330.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const GlobalLoading());
                      } else {
                        return Container(
                          height: 50.h,
                          width: 330.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor,
                          ),
                          margin: const EdgeInsets.only(top: 25),
                          // ignore: deprecated_member_use
                          child: TextButton(
                              onPressed: () async {
                                controller.sendCodeOtpStudent(
                                  otp: codeController.text,
                                  userID: id!,
                                );
                              },
                              child: const Text(
                                ' تاكيد',
                                style: TextStyle(
                                    color: buttonTextColor,
                                    fontFamily: 'Janna LT Regular',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
