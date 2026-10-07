import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgramSectionItem extends StatelessWidget {
  const ProgramSectionItem({
    required this.title,
    required this.image,
    required this.onClick,
    Key? key,
  }) : super(key: key);
  final String title, image;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    print(" ${userToken}");
    return InkWell(
      onTap: onClick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              height: 90.h,
              width: 90.h,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              height: 90.h,
              width: 90.h,
              margin: const EdgeInsets.all(10),
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 1,
              )),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: appFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
