import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Controllers/celeb/celeb_controller.dart';
import '../../constants.dart';
import '../celebrity/add_educational_curricula.dart';
import '../celebrity/add_video_screen.dart';
import '../celebrity/live/start_live_session_screen.dart';
import '../celebrity/assignments/upload_assignment_screen.dart';

class HomeCeleb extends StatefulWidget {
  HomeCeleb({Key? key}) : super(key: key);

  @override
  State<HomeCeleb> createState() => _HomeCelebState();
}

class _HomeCelebState extends State<HomeCeleb> {
  late CelebController celebController;
  @override
  void initState() {
    if (!Get.isRegistered<CelebController>()) {
      celebController = Get.put(CelebController());
    } else {
      celebController = Get.find<CelebController>();
    }
    celebController.getPrograms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async {
            await celebController.getPrograms();
            return Future.value(true);
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20.w, 35.h, 20.w, 16.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          primaryColor.withOpacity(0.14),
                          primaryColor.withOpacity(0.03),
                          Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "أهلاً، ",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Janna LT Regular',
                                color: Colors.black87,
                              ),
                            ),
                            Obx(() {
                              return Text(
                                celebController.fullName.value.toString().isNotEmpty ? celebController.fullName.value.toString() : "د. أحمد الشريف",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Janna LT Regular',
                                  color: primaryColor,
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "لوحة تحكم المعلم وإدارة البرامج والدورات",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade500,
                            fontFamily: 'Janna LT Regular',
                          ),
                        ),
                        SizedBox(height: 6.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Teacher Quick Actions
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildTeacherActionCard(
                              icon: Icons.add_circle_outline,
                              title: "إضافة دورة",
                              onTap: () {
                                Get.to(() => AddEducationalCurricula());
                              },
                            ),
                            SizedBox(width: 8.w),
                            _buildTeacherActionCard(
                              icon: Icons.video_call_outlined,
                              title: "رفع فيديو",
                              onTap: () {
                                Get.to(() => AddVideoScreen());
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            _buildTeacherActionCard(
                              icon: Icons.live_tv_rounded,
                              title: "بث مباشر",
                              onTap: () {
                                Get.to(() => const StartLiveSessionScreen());
                              },
                            ),
                            SizedBox(width: 8.w),
                            _buildTeacherActionCard(
                              icon: Icons.assignment_outlined,
                              title: "مذكرات / امتحانات",
                              onTap: () {
                                Get.to(() => const UploadAssignmentScreen());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'دورات وبرامج المعلم',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna LT Regular',
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Obx(() {
                          if (celebController.isHomeLoading.value) {
                            return Padding(
                              padding: EdgeInsets.only(top: 40.h),
                              child: const Center(child: GlobalLoading()),
                            );
                          }
                          return _buildProgramsGrid(context);
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildProgramsGrid(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 900 ? 4 : (width > 600 ? 3 : 2);

    if (celebController.programsData.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Text(
            "لا توجد دورات مضافة حالياً",
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: 'Janna LT Regular',
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.72,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: celebController.programsData.length,
      itemBuilder: (context, index) {
        final program = celebController.programsData[index];
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 100.h,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: program.image ?? '',
                errorWidget: (context, url, error) => Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                program.name ?? 'لا يوجد اسم',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Janna LT Regular',
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                program.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: 'Janna LT Regular',
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeacherActionCard({required IconData icon, required String title, required VoidCallback onTap}) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: primaryColor, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
