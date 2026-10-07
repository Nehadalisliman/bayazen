// ignore_for_file: must_be_immutable

import 'package:e_learning/Controllers/browsing_controller.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section5_items_view.dart';
import 'package:e_learning/Screens/celebrity/custom_switch_state.dart';
import 'package:e_learning/Screens/celebrity/store/story_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/shared_pref.dart';

class ProgramsSection extends StatelessWidget {
  final bool isBrowsing;
  final int? celebId;
  final String? userType;
  ProgramsSection(
      {Key? key, this.isBrowsing = false, this.celebId, this.userType})
      : super(key: key);

  var controller = Get.find<CelebController>();
  var celebBrowsingController = Get.find<BrowsingController>();
  @override
  Widget build(BuildContext context) {
    print("celebToken ${userToken}");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((isBrowsing &&
                celebBrowsingController.celebrityProgramData != []) ||
            controller.celebrityProgramData != [])
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: CustomTextWidget(
              title: "برامج اكتشف مدينة بايزين",
              titleTextStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontFamily: appFont,
              ),
            ),
          ),
        SizedBox(height: 10.sp),
        isBrowsing
            ? !celebBrowsingController.celebrityProgramData.isEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: celebBrowsingController.celebrityProgramData
                            .map((program) {
                          if (userType != 'celeb') {
                            if (program.name == "مجلة بادئة القصص") {
                              return SizedBox.shrink();
                            } else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ProgramSectionItem(
                                  title: program.name ?? "لا يوجد اسم",
                                  image: program.image,
                                  onClick: () {
                                    Get.to(CustomSwitchState(
                                      isBrowsing: true,
                                      celebId: celebId,
                                      programID: program.id,
                                      programTitle: program.name,
                                    ));
                                  },
                                ),
                              );
                            }
                          }
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ProgramSectionItem(
                              title: program.name ?? "لا يوجد اسم",
                              image: program.image,
                              onClick: () {
                                if (program.name == "مجلة بادئة القصص") {
                                  Get.to(StoryProfile(
                                    isBrowsing: true,
                                    celebId: celebId,
                                  ));
                                  return;
                                }
                                Get.to(CustomSwitchState(
                                  isBrowsing: true,
                                  celebId: celebId,
                                  programID: program.id,
                                  programTitle: program.name,
                                ));
                              },
                            ),
                          );
                        }).toList()),
                  )
                : Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "لا يوجد برامج مشارك فيها",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
            : !controller.celebrityProgramData.isEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                            controller.celebrityProgramData.map((program) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ProgramSectionItem(
                              title: program.name ?? "لا يوجد اسم",
                              image: program.image,
                              onClick: () {
                                if (program.name == "مجلة بادئة القصص") {
                                  Get.to(StoryProfile(
                                    isBrowsing: false,
                                    celebId: celebId,
                                  ));
                                  return;
                                }
                                Get.to(CustomSwitchState(
                                  programID: program.id,
                                  programTitle: program.name,
                                ));
                              },
                            ),
                          );
                        }).toList()),
                  )
                : Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "لا يوجد برامج مشارك فيها",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
      ],
    );
  }
}
