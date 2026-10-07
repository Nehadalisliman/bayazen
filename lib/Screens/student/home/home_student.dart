import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning/Controllers/student/student_home_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Screens/student/student_browsing/student_browsing.dart';
import 'package:e_learning/Screens/student/auth/student_login_screen.dart';
import 'package:e_learning/Screens/celebrity/auth/login_celebrity_screen.dart';
import 'package:e_learning/Screens/student/profile/student_profile.dart';
import 'package:e_learning/Screens/student/channels_screen.dart';
import 'package:e_learning/Screens/student/student_buttom_nav_bar.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_text.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_svg_image.dart';
import 'package:e_learning/Widgets/fade_in_slide.dart';
import 'package:e_learning/core/Services/firebase_service.dart';

class HomeStudent extends StatelessWidget {
  HomeStudent({Key? key}) : super(key: key);

  final controller = Get.put<StudentHomeController>(StudentHomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8F9FA),
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          await controller.getPrograms();
          return Future.value(true);
        },
        child: FadeInSlide(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      primaryColor.withOpacity(0.18),
                      primaryColor.withOpacity(0.04),
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28.r),
                    bottomRight: Radius.circular(28.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Menu Button
                        InkWell(
                          onTap: () {
                            _showStudentDrawer(context);
                          },
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(Icons.menu_rounded, size: 20.sp, color: primaryColor),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.school_rounded, size: 14.sp, color: primaryColor),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "منصة بيازين",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Janna LT Regular',
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            // Search Button
                            InkWell(
                              onTap: () {
                                _showSearchDialog(context, controller);
                              },
                              borderRadius: BorderRadius.circular(20.r),
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.search_rounded, size: 20.sp, color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Text(
                          "أهلاً بك، ",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna LT Regular',
                            color: Colors.black87,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            controller.fullName.value.isNotEmpty
                                ? controller.fullName.value
                                : "طالب بايزين",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Janna LT Regular',
                              color: primaryColor,
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "استكشف أحدث الدورات والبرامج التعليمية المميزة وتطوير مهاراتك",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
                        fontFamily: 'Janna LT Regular',
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // (Banner removed)

              // Live Streams Banner Section
              FutureBuilder<List<Map<String, dynamic>>>(
                future: FirebaseService().getCollection('live_sessions'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  final activeLives = snapshot.data!.where((s) => s['isLive'] == true).toList();
                  if (activeLives.isEmpty) return const SizedBox.shrink();

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10.w,
                              height: 10.w,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "بث مباشر الآن 🔴",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Janna LT Regular',
                                color: Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        ...activeLives.map((live) => Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: Colors.red.shade200, width: 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.live_tv_rounded, color: Colors.white, size: 22.sp),
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      live['title'] ?? 'محاضرة بث مباشر',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Janna LT Regular',
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      live['instructor'] ?? 'د. أحمد الشريف',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: 'Janna LT Regular',
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                onPressed: () {
                                  Get.snackbar(
                                    "انضمام للبث",
                                    "جاري فتح البث المباشر...",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                },
                                child: Text(
                                  "انضمام",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Janna LT Regular',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),

              // Courses Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: 'اكتشف مدينة بايزين',
                          color: Colors.black87,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        Text(
                          "الكل",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna LT Regular',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Obx(() {
                      if (controller.isProgramsLoading.value) {
                        return Padding(
                          padding: EdgeInsets.only(top: 80.h),
                          child: const Center(child: GlobalLoading()),
                        );
                      } else if (controller.progData.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(28.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.r),
                                border: Border.all(color: primaryColor.withOpacity(0.1), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.06),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20.w),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.school_outlined, size: 44.sp, color: primaryColor),
                                  ),
                                  SizedBox(height: 18.h),
                                  Text(
                                    "لا توجد كورسات متاحة حالياً",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Janna LT Regular',
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    "نعمل جاهدين لإضافة أحدث الدورات والبرامج التعليمية المميزة قريباً.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: 'Janna LT Regular',
                                      color: Colors.grey.shade500,
                                      height: 1.4,
                                    ),
                                  ),
                                  SizedBox(height: 22.h),
                                  SizedBox(
                                    width: 180.w,
                                    height: 44.h,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.r),
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.getPrograms();
                                      },
                                      icon: const Icon(Icons.refresh_rounded, color: Colors.white, size: 18),
                                      label: Text(
                                        "تحديث البيانات",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontFamily: 'Janna LT Regular',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return ProgramStudentList(context, controller);
                      }
                    }),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showStudentDrawer(BuildContext context) {
    Get.dialog(
      barrierColor: Colors.black54,
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 280.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                bottomLeft: Radius.circular(24.r),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50.h, bottom: 20.h, left: 20.w, right: 20.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withOpacity(0.85)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28.r,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 28.sp, color: primaryColor),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.fullName.value.isNotEmpty ? controller.fullName.value : "طالب بايزين",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Janna LT Regular',
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "منصة بيازين التعليمية",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10.sp,
                                fontFamily: 'Janna LT Regular',
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else {
                            Get.back();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close_rounded, color: Colors.white, size: 20.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    children: [
                      _buildDrawerItem(
                        icon: CupertinoIcons.home,
                        title: "الرئيسية",
                        onTap: () => Get.back(),
                      ),
                      _buildDrawerItem(
                        icon: CupertinoIcons.search,
                        title: "استكشاف الدورات",
                        onTap: () {
                          Get.back();
                          _showSearchDialog(context, controller);
                        },
                      ),
                      _buildDrawerItem(
                        icon: CupertinoIcons.person,
                        title: "الملف الشخصي",
                        onTap: () {
                          Get.back();
                          Get.to(() => UpdateStudentScreen());
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        child: Divider(color: Colors.grey.shade200),
                      ),
                      _buildDrawerItem(
                        icon: Icons.admin_panel_settings_outlined,
                        title: "تسجيل الدخول كمؤثر / معلم",
                        color: Colors.blue.shade700,
                        onTap: () {
                          Get.back();
                          Get.to(() => LoginCelebrityScreen());
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.logout,
                        title: "تسجيل الخروج",
                        color: Colors.red.shade700,
                        onTap: () {
                          SharedPrefHelper.clear();
                          Get.offAll(() => StudentBottomNavBar());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final itemCardColor = color ?? Colors.black87;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: itemCardColor == Colors.red || itemCardColor == Colors.red.shade700 ? Colors.red.shade50 : primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, color: itemCardColor == Colors.red || itemCardColor == Colors.red.shade700 ? Colors.red.shade700 : primaryColor, size: 20.sp),
                ),
                SizedBox(width: 14.w),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Janna LT Regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: itemCardColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context, StudentHomeController controller) {
    final TextEditingController searchController = TextEditingController();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "استكشاف الدورات",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Janna LT Regular',
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "ابحث عن دورة تعليمية...",
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 42.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("بحث", style: TextStyle(color: Colors.white, fontFamily: 'Janna LT Regular')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ProgramStudentList(BuildContext context, StudentHomeController controller) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 900 ? 4 : (width > 600 ? 3 : 2);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.72,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.progData.length,
      itemBuilder: (context, index) {
        final program = controller.progData[index];
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
}
