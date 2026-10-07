import 'dart:developer';

import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SaveButtonWidget extends StatelessWidget {
  final String data, modification;
  final void Function() onPressed;
  final double heigh;
  SaveButtonWidget(
      {Key? key,
      required this.heigh,
      required this.data,
      required this.modification,
      required this.onPressed})
      : super(key: key);

  final ContentController contentController = Get.put(ContentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigh ?? 30.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        color: Colors.blue,
      ),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
          ),
          onPressed: onPressed,
          //  ??
          // () {
          //   // log
          //   log("Data $data");
          //   contentController.updateData(
          //       data: data, modification: modification);
          // },
          child: Text(
            ' حفظ',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Janna LT Regular',
                fontWeight: FontWeight.bold,
                fontSize: 9.sp),
          )),
    );
  }
}
