import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/custom_text.dart';
import 'package:e_learning/Widgets/vedio_item.dart';
import 'package:e_learning/core/helpers/size_config.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:e_learning/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../constants.dart';
import '../old_work/identification_screen.dart';

class CelebrityProfile extends StatefulWidget {
  @override
  _CelebrityProfileState createState() => _CelebrityProfileState();
}

class _CelebrityProfileState extends State<CelebrityProfile> {
  SizeConfig sizeConfig = SizeConfig();
  final controller = Get.find<CelebController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.delayed(Duration.zero, () {
        CelebController().getCelebrityProfile();
      }),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            DropdownButton(items: [
              DropdownMenuItem(
                  child: Row(
                children: [
                  customText(
                      text: 'مشاركه الصفحه الشخصيه',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal),
                  Icon(Icons.share),
                ],
              )),
              DropdownMenuItem(
                  child: Row(
                children: [
                  customText(
                      text: 'تعديل الصفحه الشخصيه',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal),
                  Icon(Icons.edit),
                ],
              )),
            ], onChanged: (dynamic val) {}, icon: Icon(Icons.menu_rounded)),
            // IconButton(onPressed: (){
            //
            // }, icon: Icon(Icons.menu_rounded))
          ],
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: const Text('الصفحه الشخصيه',
              style: TextStyle(
                  color: accentColor,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          // leading: InkWell(
          //     onTap: () {
          //       Get.back();
          //     },
          //     child: const Icon(
          //       Icons.arrow_back,
          //       color: accentColor,
          //     )),
          backgroundColor: buttonTextColor,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: sizeConfig.screenWidth * .03,
                          ),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    controller.celebrityResponseModel.image!),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: sizeConfig.screenHeight * .01),
                            child: Text(
                                '${controller.celebrityResponseModel.name}',
                                style: TextStyle(
                                    fontFamily: 'Janna LT Regular',
                                    color: accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/biazin.png',
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),

                    // Row(
                    //   children: [
                    //     Container(
                    //         margin: EdgeInsets.only(
                    //             left: sizeConfig.screenWidth * .6,
                    //             top: sizeConfig.screenHeight * .03),
                    //         child: Text(
                    //             '${controller.celebrityResponseModel.}',
                    //             style: TextStyle(
                    //                 fontFamily: 'Janna LT Regular',
                    //                 color: accentColor,
                    //                 fontWeight: FontWeight.normal,
                    //                 fontSize: 17))),
                    //   ],
                    // ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            customText(
                                text: '2',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                            customText(
                                text: 'مجلات',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ],
                        ),
                        Column(
                          children: [
                            customText(
                                text: '5',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                            customText(
                                text: 'فديوهات',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ],
                        ),
                        Column(
                          children: [
                            customText(
                                text: '109',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                            customText(
                                text: 'منشور',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    customText(
                        text: 'الفديو التعريفي',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    controller.celebrityResponseModel.personal_vid == ''
                        ? customText(
                            text:
                                'الفيديو التعريفي يزيد من تاثيرك ومدي وصولك للناس',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey)
                        : SizedBox(
                            height: sizeConfig.screenHeight * .3,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                              child: AspectRatio(
                                            aspectRatio: 19 / 9,
                                            child: VideoItems(
                                              videoPlayerController:
                                                  VideoPlayerController.network(
                                                      controller
                                                          .celebrityResponseModel
                                                          .personal_vid!),
                                              looping: true,
                                              autoplay: false,
                                              width: sizeConfig.screenWidth,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    controller.celebrityResponseModel.personal_vid == ''
                        ? const SizedBox()
                        : ProgressBar(
                            progress: Duration(minutes: 5),
                            buffered: Duration(milliseconds: 2000),
                            total: Duration(milliseconds: 5000),
                            progressBarColor: Colors.red,
                            baseBarColor: Colors.white.withOpacity(0.24),
                            bufferedBarColor: Colors.white.withOpacity(0.24),
                            thumbColor: Colors.white,
                            barHeight: 3.0,
                            thumbRadius: 5.0,
                            onSeek: (duration) {
                              print('User selected a new time: $duration');
                            },
                          ),
                    customText(
                        text: 'مكتبة الفديوهات',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),

                    SizedBox(
                      height: sizeConfig.screenHeight * .2,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('الخبرات ',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'Janna LT Regular',
                                        color: accentColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                          .celebrityResponseModel
                                          .experience!
                                          .length,
                                      itemBuilder: (context, number) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  '${controller.celebrityResponseModel.experience![index]}'),

                                              // Text('${snapshot.data.experience[index][3]}'),
                                            ],
                                          ),
                                        );
                                      }),
                                  height: 300,
                                );
                              },
                              itemCount: controller
                                  .celebrityResponseModel.experience!.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: sizeConfig.screenHeight * .2,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('التعليم ',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'Janna LT Regular',
                                        color: accentColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          '${controller.celebrityResponseModel.eduction![index]}'),
                                    ],
                                  ),
                                );
                              },
                              itemCount: controller
                                  .celebrityResponseModel.eduction!.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: sizeConfig.screenHeight * .2,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(' المهارات',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'Janna LT Regular',
                                        color: accentColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (snap, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          '${controller.celebrityResponseModel.skills![index]}'),
                                    ],
                                  ),
                                );
                              },
                              itemCount: controller
                                  .celebrityResponseModel.skills!.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: sizeConfig.screenHeight * .2,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('الاهتمامات ',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'Janna LT Regular',
                                        color: accentColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (snap, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          '${controller.celebrityResponseModel.interests![index]}'),
                                    ],
                                  ),
                                );
                              },
                              itemCount: controller
                                  .celebrityResponseModel.interests!.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: sizeConfig.screenHeight * .2,
                    //   width: double.infinity,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Column(
                    //       children: [
                    //         Column(
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Text('نبذة عنا',
                    //                     textAlign: TextAlign.right,
                    //                     style: TextStyle(
                    //                         fontFamily:
                    //                             'Janna LT Regular',
                    //                         color: accentColor,
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 18)),
                    //               ],
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Expanded(
                    //                     child: Text(
                    //                         ' ${controller.celebrityResponseModel.bio}',
                    //                         textAlign: TextAlign.right,
                    //                         style: TextStyle(
                    //                             fontFamily:
                    //                                 'Janna LT Regular',
                    //                             color: accentColor,
                    //                             fontWeight:
                    //                                 FontWeight.normal,
                    //                             fontSize: 12))),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    ListTile(
                      onTap: () {
                        SharedPrefHelper.clear();
                        Get.offAll(IdentificationScreen());
                      },
                      leading: Text('تسجيل الخروج'),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const GlobalLoading();
          }
        }),
      ),
    );
  }
}
