import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileAppBar extends StatelessWidget {
  const EditProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconBtnWidget(
            onClick: () {
              Get.back();
            },
            icon: Icons.arrow_back_outlined,
            size: 20.sp,
            color: Colors.black,
          ),
          Expanded(
            child: Text(
              "تعديل الصفحة الشخصية",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                fontFamily: appFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconButton iconBtnWidget({
    required Function() onClick,
    required IconData icon,
    required double size,
    required Color color,
  }) {
    return IconButton(
      onPressed: onClick,
      icon: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}
