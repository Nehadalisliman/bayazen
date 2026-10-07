import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

Widget customElevatedButton({
  required String text,
  required Function() onPressed,
  Color color = Colors.black,
  double width = double.infinity,
  double height = 45,
  double fontSize = 16,
  double radius = 8,
}) =>
    SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: Colors.blue,
          maximumSize:  Size(360.w, 50.h),
        ),
        onPressed: onPressed,
        child: customText(
          fontWeight: FontWeight.w500,
          text: text,
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );
