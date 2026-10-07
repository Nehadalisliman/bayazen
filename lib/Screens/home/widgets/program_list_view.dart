import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning/Screens/celebrity/library/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Controllers/celeb/celeb_controller.dart';
import '../../../Models/celebrity/chapter_model.dart';
import '../../../Widgets/custom_elevated_button.dart';
import '../../../Widgets/custom_text.dart';
import '../../../constants.dart';
import '../../../core/global/globalloading.dart';
import '../../celebrity/program_details.dart';
import '../../celebrity/store/story_screen.dart';

class ProgramListView extends StatefulWidget {
  ProgramListView({Key? key}) : super(key: key);

  @override
  State<ProgramListView> createState() => _ProgramListViewState();
}

class _ProgramListViewState extends State<ProgramListView> {
  final controller = Get.find<CelebController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isHomeLoading.value) {
          return Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: GlobalLoading(),
          );
        } else {
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
            childAspectRatio: .65,
            children: List.generate(
              controller.programsData.length,
              (index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  height: 330.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        height: 90.h,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: controller.programsData[index].image,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 90.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              image: DecorationImage(
                                  fit: BoxFit.fill, image: imageProvider)),
                        ),
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                          color: Colors.blue,
                          strokeWidth: 1,
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),

                      SizedBox(
                        height: 2.sp,
                      ),

                      // todo Name
                      customText(
                          text: controller.programsData[index].name ??
                              'لا يوجد اسم',
                          color: Colors.blueAccent,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        height: 2.sp,
                      ),
                      // todo description
                      customText(
                          text: controller.programsData[index].description,
                          color: Colors.black,
                          maxLines: 3,
                          fontSize: 9.sp,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal),

                      Expanded(
                          child: SizedBox(
                        height: 10.h,
                      )),
                      customElevatedButton(
                          text: "مشاهده المزيد",
                          height: 22.sp,
                          fontSize: 10.sp,
                          onPressed: () {
                            // todo Dialog Content
                            showAlertDialog(
                              context,
                              index,
                            );
                            // todo End Dialog
                          }),
                      SizedBox(
                        height: 2.sp,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  showAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 500.h,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                      )),

                  SizedBox(
                    height: 5,
                  ),
                  CachedNetworkImage(
                    height: 90.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    imageUrl: controller.programsData[index].image,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 130.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                              fit: BoxFit.fill, image: imageProvider)),
                    ),
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 1,
                    )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),

                  SizedBox(
                    height: 10.sp,
                  ),
                  // todo name
                  customText(
                      text:
                          controller.programsData[index].name ?? "لا يوجد اسم",
                      color: primaryColor,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: 5.sp,
                  ),
                  // todo description
                  Expanded(
                    child: customText(
                        text: controller.programsData[index].description,
                        color: Colors.grey,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 10.sp),
                  customElevatedButton(
                      fontSize: 12.sp,
                      text:
                          'شارك خبراتك مع ${controller.programsData[index].name} ',
                      onPressed: () {
                        if (controller.programsData[index].name ==
                            "مجلة بادئة القصص") {
                          Get.to(StoryScreen());
                          return;
                        }
                        // Get.to(
                        //   () => LibraryScreen(
                        //     celebController: controller,
                        //     programId: controller.programsData[index].id,
                        //   ),
                        // );
                        Get.to(ProgramDetailsScreen(
                          libraries: [],
                          celebController: controller,
                          // chapters: controller.chapters,
                          title: controller.programsData[index].name ??
                              "لا يوجد اسم",
                          programId: controller.programsData[index].id,
                        ));
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

            /*  Container(
                                    height: 90.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              controller
                                                  .programsData[index].image,
                                            ))),
                                  ),*/