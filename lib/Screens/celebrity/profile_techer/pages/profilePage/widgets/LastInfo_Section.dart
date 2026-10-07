import 'package:e_learning/Controllers/browsing_controller.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LastInfoSection extends StatelessWidget {
  final bool isBrowsing;
  LastInfoSection({Key? key, this.isBrowsing = false}) : super(key: key);
  final controller = Get.find<CelebController>();
  final browsingController = Get.find<BrowsingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.centerRight,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // todo experience
            ProfileExperItems(
              title: "الخبرات",
              experiancedata: isBrowsing
                  ? (browsingController.celebrityResponseModel?.experience ?? [])
                  : (controller.celebrityResponseModel.experience ?? []),
            ),
            // todo eduction
            ProfileEducationItems(
              title: "التعليم",
              educationdata: isBrowsing
                  ? (browsingController.celebrityResponseModel?.eduction ?? [])
                  : (controller.celebrityResponseModel.eduction ?? []),
            ),
            // todo skills
            ProfileSection6Items(
              title: "المهارات",
              listData: isBrowsing
                  ? (browsingController.celebrityResponseModel?.skills ?? [])
                  : (controller.celebrityResponseModel.skills ?? []),
            ),
            // todo interests
            ProfileSection6Items(
              title: "الاهتمام",
              listData: isBrowsing
                  ? (browsingController.celebrityResponseModel?.interests ?? [])
                  : (controller.celebrityResponseModel.interests ?? []),
            ),
            SizedBox(
              height: 10.sp,
            )
          ],
        ),
      ),
    );
  }
}

class ProfileSection6Items extends StatelessWidget {
  ProfileSection6Items({required this.title, required this.listData, Key? key})
      : super(key: key);
  final String title;
  List<dynamic>? listData = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //controller.celebrityResponseModel
          CustomTextWidget(
            title: title,
            titleTextStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: appFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (listData!.isEmpty)
            Text(
              "لا يوجد",
              style: TextStyle(color: Colors.grey),
            ),
          ...List.generate(
              listData!.length,
              (index) =>
                  InfoProfileWidget(infoItem: listData![index].toString())),
        ],
      ),
    );
  }
}

class ProfileExperItems extends StatelessWidget {
  ProfileExperItems(
      {required this.title, required this.experiancedata, Key? key})
      : super(key: key);
  final String title;
  List<dynamic>? experiancedata = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //controller.celebrityResponseModel
          CustomTextWidget(
            title: title,
            titleTextStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: appFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (experiancedata!.isEmpty ||
              experiancedata == [] ||
              experiancedata == null)
            Text(
              "لا يوجد",
              style: TextStyle(color: Colors.grey),
            ),
          ...List.generate(
            experiancedata!.length,
            (index) => InfoProfileWidget(
                infoItem: "الكليه : ${experiancedata![index]}" +
                    "  \n  " +
                    "التخصص : ${experiancedata![index]}" +
                    "  \n  " +
                    "البدايه : ${experiancedata![index]}" +
                    "   \n " +
                    "النهايه : ${experiancedata![index]}"),
            // experiancedata![index]
          ),
        ],
      ),
    );
  }
}

class ProfileEducationItems extends StatelessWidget {
  ProfileEducationItems(
      {required this.title, required this.educationdata, Key? key})
      : super(key: key);
  final String title;
  List<dynamic>? educationdata = [];

  @override
  Widget build(BuildContext context) {
    print(educationdata);
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //controller.celebrityResponseModel
          CustomTextWidget(
            title: title,
            titleTextStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: appFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (educationdata!.isEmpty || educationdata == [])
            Text(
              "لا يوجد",
              style: TextStyle(color: Colors.grey),
            ),
          ...List.generate(
            educationdata!.length,
            (index) => InfoProfileWidget(
              infoItem: "الكليه : ${educationdata![index]}" +
                  "  \n  " +
                  "التخصص : ${educationdata![index]}" +
                  "  \n  " +
                  "البدايه : ${educationdata![index]}" +
                  "   \n " +
                  "النهايه : ${educationdata![index]}",
            ),
          ),
        ],
      ),
    );
  }
}

class InfoProfileWidget extends StatelessWidget {
  final String infoItem;
  const InfoProfileWidget({Key? key, required this.infoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      //controller.celebrityResponseModel

      SizedBox(height: 10.sp),
      Text(
        infoItem,
        maxLines: 4,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 12.sp,
          fontFamily: appFont,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      Divider(
        color: Colors.grey[300],
        height: 1.2,
        endIndent: 2,
        indent: 2,
        thickness: 1.5,
      ),
    ]);
  }
}
