import 'package:e_learning/Screens/celebrity/auth/login_celebrity_screen.dart';

import 'package:e_learning/Screens/student/auth/student_login_screen.dart';

import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({Key? key}) : super(key: key);
  @override
  _IdentificationScreenState createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  String logoTitle =
      "أما في الدهر من أُفضي إليه بأسراري فيُؤنِسَ بالجواب يَئِستُ من الأنام فما جليسٌ سرى عنّي الهموم سوى كِتابي ";
  String _logoTitle = 'بادئ القصص';
  @override
  void initState() {
    // TODO:implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/biazin.png',
              height: 130.h,
              width: 130.h,
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Text(
              _logoTitle,
              style: TextStyle(
                  fontFamily: 'Janna LT Regular',
                  fontSize: 20.sp,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          )),
          SizedBox(
            height: 25.h,
          ),
          Center(
              child: TextButton(
                  onPressed: () {
                    Get.to(()=>LoginCelebrityScreen());
                  },
                  child: Text('تسجيل دخول كمؤثر',
                      style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Janna LT Regular',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold)))),
          Center(
              child: TextButton(
                  onPressed: () {
                    Get.to( ()=> LoginStudent());
                  },
                  child: Text('تسجيل دخول كطالب',
                      style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Janna LT Regular',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold))))
        ],
      ),
    );
  }
}
