import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/editprofile/edit_prfile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBarSection extends StatelessWidget {
  final bool isBrowsing;
  final bool isLoading;
  final CelebController profileController;
  const AppBarSection({
    Key? key,
    this.isLoading = false,
    this.isBrowsing = false,
    required this.profileController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: .5,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isBrowsing)
              SizedBox(
                width: 20.sp,
              ),
            if (isBrowsing)
              SizedBox(
                width: 20.sp,
              ),
            Text(
              "الصفحة الشخصية",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                fontFamily: appFont,
              ),
            ),
            SizedBox(
              width: 20.sp,
            ),
          ],
        ),
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
