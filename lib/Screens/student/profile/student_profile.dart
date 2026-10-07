import 'package:e_learning/Controllers/student/student_controller.dart';
import 'package:e_learning/Screens/student/auth/student_login_screen.dart';
import 'package:e_learning/Screens/celebrity/auth/login_celebrity_screen.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Screens/student/profile/update_student_profile.dart';
import 'package:e_learning/Widgets/app_color.dart' hide primaryColor;
import 'package:e_learning/constants.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateStudentScreen extends StatefulWidget {
  UpdateStudentScreen({Key? key}) : super(key: key);

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    final String? token = SharedPrefHelper.getPref('token');
    if (token == null || token.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            "الصفحة الشخصية",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                fontFamily: 'Janna LT Regular'),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.lock_outline_rounded, size: 38.sp, color: primaryColor),
                ),
                SizedBox(height: 16.h),
                Text(
                  "يرجى تسجيل الدخول أولاً",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "قم بتسجيل الدخول للوصول إلى ملفك الشخصي ومتابعة دوراتك التعليمية.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 200.w,
                  height: 42.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => LoginStudent());
                    },
                    child: Text(
                      "تسجيل الدخول",
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
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "الصفحة الشخصية",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              fontFamily: 'Janna LT Regular'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async {
            await controller.getCurrentStudentProfile();
            return Future.value(true);
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            children: [
              Obx(() {
                if (controller.isProfileLoading.value) {
                  return SizedBox(
                    height: 0.6.sh,
                    child: const Center(child: GlobalLoading()),
                  );
                }

                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            primaryColor.withOpacity(0.12),
                            primaryColor.withOpacity(0.03),
                            Colors.white,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 55.r,
                                backgroundColor: Colors.white,
                                backgroundImage: controller.profileModel.image != "" &&
                                        controller.profileModel.image != null
                                    ? Image.network(controller.profileModel.image!).image
                                    : Image.asset("assets/biz.png").image,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: const BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.verified, color: Colors.white, size: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            controller.profileModel.name ?? "طالب بايزين",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Janna LT Regular',
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            controller.profileModel.email ?? "",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Janna LT Regular',
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.work_outline, "الوظيفة", controller.profileModel.occupation ?? "غير محدد"),
                          Divider(height: 24.h),
                          _buildInfoRow(Icons.description_outlined, "السيرة الذاتية", controller.profileModel.bio ?? "لا توجد سيرة ذاتية"),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Stats Row
                    Row(
                      children: [
                        _buildStatCard("الدورات", "4", Icons.book_outlined),
                        SizedBox(width: 12.w),
                        _buildStatCard("الساعات", "24h", Icons.access_time),
                        SizedBox(width: 12.w),
                        _buildStatCard("الشهادات", "2", Icons.workspace_premium_outlined),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildActionTile(
                            icon: Icons.edit_outlined,
                            title: "تعديل الملف الشخصي",
                            onTap: () {
                              Get.to(() => UpdateProfile(
                                    email: controller.profileModel.email,
                                    image: controller.profileModel.image,
                                    name: controller.profileModel.name,
                                    occupation: controller.profileModel.occupation,
                                    bio: controller.profileModel.bio,
                                  ));
                            },
                          ),
                          Divider(height: 1, indent: 56.w, endIndent: 16.w),
                          _buildActionTile(
                            icon: Icons.admin_panel_settings_outlined,
                            title: "تسجيل الدخول كمؤثر / معلم",
                            onTap: () {
                              Get.to(() => LoginCelebrityScreen());
                            },
                          ),
                          Divider(height: 1, indent: 56.w, endIndent: 16.w),
                          _buildActionTile(
                            icon: Icons.logout,
                            title: "تسجيل الخروج",
                            color: Colors.red.shade700,
                            onTap: () {
                              SharedPrefHelper.clear();
                              Get.offAll(() => LoginStudent());
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 18.sp),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Janna LT Regular',
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 10.sp,
                fontFamily: 'Janna LT Regular',
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: 'Janna LT Regular',
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Janna LT Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: primaryColor, size: 22.sp),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final tileColor = color ?? primaryColor;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: tileColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: tileColor, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: 'Janna LT Regular',
                    fontWeight: FontWeight.w600,
                    color: tileColor,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 12.sp,
                color: tileColor.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
