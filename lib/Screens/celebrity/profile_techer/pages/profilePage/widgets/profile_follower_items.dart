import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSection3Items extends StatelessWidget {
  const ProfileSection3Items({
    required this.title,
    required this.subTitle,
    Key? key,
  }) : super(key: key);
  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextWidget(
          title: title,
          titleTextStyle: TextStyle(
            fontSize: 17.sp,
            fontFamily: appFont,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        CustomTextWidget(
          title: subTitle,
          titleTextStyle: TextStyle(
            fontSize: 15.sp,
            fontFamily: appFont,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
