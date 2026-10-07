import 'package:e_learning/Controllers/browsing_controller.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/app_colors.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/LastInfo_Section.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/prorams_section.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/video_section.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileBrowsingPage extends StatefulWidget {
  final int? celebId;

  ProfileBrowsingPage({Key? key, this.celebId}) : super(key: key);

  @override
  State<ProfileBrowsingPage> createState() => _ProfileBrowsingPageState();
}

class _ProfileBrowsingPageState extends State<ProfileBrowsingPage> {
  BrowsingController browsingController = Get.put(BrowsingController());
  CelebController teacherController = Get.put(CelebController());

  bool isTextShown = false;
  String userType = '';

  getUserType() async {
    userType = SharedPrefHelper.getPref('type') ?? '';
    print('profile userType ${userType}');
  }

  Future<void> getProfile() async {
    browsingController.getCelebProfile(celebId: widget.celebId);
  }

  @override
  void initState() {
    getUserType();
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'الملف الشخصي',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Obx(() {
            if (!browsingController.isProfileLoading.value) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // todo ==== AppBar ====

                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.sp),
                            //controller.celebrityResponseModel.image
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200.w,
                                        child: StatefulBuilder(
                                          builder: ((context, setStatee) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Visibility(
                                                        visible: isTextShown,
                                                        child: Text(
                                                          "اقتصاد الرفاه",
                                                          style: TextStyle(
                                                            fontFamily: appFont,
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AppColors
                                                                .customColor1,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setStatee(() {
                                                            isTextShown =
                                                                !isTextShown;
                                                          });
                                                        },
                                                        child: Image.asset(
                                                          'assets/biazin.png',
                                                          height: 30.sp,
                                                          width: 30.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 7.sp,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: CustomTextWidget(
                                                      title: browsingController
                                                                  .celebrityResponseModel!
                                                                  .name !=
                                                              ''
                                                          ? browsingController
                                                              .celebrityResponseModel!
                                                              .name
                                                          : "",
                                                      titleTextStyle: TextStyle(
                                                        fontFamily: appFont,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 2.sp),
                                      Container(
                                        width: 200.w,
                                        // color: Colors.red,
                                        child: Text(
                                          browsingController
                                                      .celebrityResponseModel!
                                                      .specialization ==
                                                  ''
                                              ? "لايوجد تخصصك"
                                              : browsingController
                                                  .celebrityResponseModel!
                                                  .specialization!,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontFamily: appFont,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.customColor1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5.sp),
                                    ],
                                  ),
                                  SizedBox(width: 20.w),

                                  // todo الصوره
                                  CircleAvatar(
                                    radius: 40.r,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: browsingController
                                                .celebrityResponseModel!
                                                .image !=
                                            "https://elbyazin-s3.s3.me-south-1.amazonaws.com/images/celebs/profile/def_avatar.png"
                                        ? Image.network(
                                            browsingController
                                                .celebrityResponseModel!.image!,
                                          ).image
                                        : Image.asset(
                                            userImg,
                                            fit: BoxFit.fill,
                                            width: 100,
                                            height: 100,
                                          ).image,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10.h),
                            Divider(
                              color: Colors.grey,
                            ),
                            bioWidget(),
                            Divider(
                              color: Colors.grey,
                            ),

                            // todo Video
                            VideoSection(
                                isBrowing: true,
                                video: browsingController
                                    .celebrityResponseModel!.personal_vid),
                            SizedBox(height: 15),
                            Divider(
                              color: Colors.grey,
                            ),
                            // todo برامج
                            ProgramsSection(
                              userType: userType,
                              isBrowsing: true,
                              celebId:
                                  browsingController.celebrityResponseModel!.id,
                            ),
                            SizedBox(height: 15),
                            Divider(
                              color: Colors.grey,
                            ),

                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: LastInfoSection(
                                isBrowsing: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]);
            }
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child:
                    Align(alignment: Alignment.center, child: GlobalLoading()),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget bioWidget() {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            title: "نبذه عنه",
            titleTextStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: appFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            child: Text(
              browsingController.celebrityResponseModel!.bio == ''
                  ? ' لايوجد نبذه عنه'
                  : browsingController.celebrityResponseModel!.bio!,
              softWrap: false,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontFamily: appFont,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
