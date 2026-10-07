import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/app_bar_section.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/shared_pref.dart';
import '../../../../../constants.dart';
import 'package:e_learning/Screens/student/student_buttom_nav_bar.dart';
import '../editprofile/edit_prfile_page.dart';

class ProfileDetailsPage extends StatefulWidget {
  ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  final celebController = Get.put(CelebController());

  @override
  void initState() {
    celebController.getCelebrityProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: GetBuilder<CelebController>(builder: (controller) {
        if (celebController.isProfileLoading) {
          return const Center(child: GlobalLoading());
        }
        final profile = celebController.celebrityResponseModel;
        return Column(
          children: [
            AppBarSection(profileController: celebController),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header Card
                    Container(
                      padding: EdgeInsets.all(20.w),
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
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 38.r,
                            backgroundColor: Colors.blue.shade50,
                            backgroundImage: profile.image != null && profile.image!.isNotEmpty
                                ? NetworkImage(profile.image!)
                                : const AssetImage('assets/biz.png') as ImageProvider,
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.name ?? "د. أحمد الشريف",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Janna LT Regular',
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  profile.specialization ?? "خبير البرمجة وتطوير الويب",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Janna LT Regular',
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Bio Section
                    Text(
                      "نبذة عن المعلم",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Janna LT Regular',
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        profile.bio != null && profile.bio!.isNotEmpty
                            ? profile.bio!
                            : "أستاذ علوم الحاسب وتطوير البرمجيات بخبرة أكثر من 10 سنوات في تقديم الدورات الاحترافية.",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Janna LT Regular',
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Actions & Settings
                    Text(
                      "الإعدادات والحساب",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Janna LT Regular',
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit_outlined, color: primaryColor, size: 20.sp),
                              title: Text(
                                "تعديل الملف الشخصي",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Janna LT Regular',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey.shade400),
                              onTap: () {
                                Get.to(() => EditProfilePage(getProfile: celebController));
                              },
                            ),
                            Divider(height: 1, color: Colors.grey.shade100),
                            ListTile(
                              leading: Icon(Icons.logout_rounded, color: Colors.red.shade400, size: 20.sp),
                              title: Text(
                                "تسجيل الخروج",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Janna LT Regular',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red.shade400,
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey.shade400),
                              onTap: () {
                                SharedPrefHelper.clear();
                                Get.offAll(() => StudentBottomNavBar());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
