import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../add_educational_curricula.dart';
import '../add_video_screen.dart';
import '../chapters/chapter_screen.dart';
import '../library/library_screen.dart';

class CelebBrowsing extends StatelessWidget {
  final String? libraryName;
  final String? programTitle;
  final int? programId;
  final bool isStudent;

  const CelebBrowsing({
    Key? key,
    this.programId,
    this.isStudent = false,
    this.libraryName,
    this.programTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "إدارة المحتوى والنشاطات",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            fontFamily: 'Janna LT Regular',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "أدوات التحكم والإنشاء",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna LT Regular',
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),
            _buildManagementCard(
              context,
              icon: Icons.add_circle_outline_rounded,
              title: "إضافة دورة تعليمية جديدة",
              subtitle: "إنشاء برنامج أو دورة تدريبية جديدة وإدارتها",
              onTap: () {
                Get.to(() => AddEducationalCurricula());
              },
            ),
            SizedBox(height: 12.h),
            _buildManagementCard(
              context,
              icon: Icons.video_call_outlined,
              title: "رفع فيديو تعليمي",
              subtitle: "إضافة درس جديد وربطه بالمنهج",
              onTap: () {
                Get.to(() => AddVideoScreen());
              },
            ),
            SizedBox(height: 12.h),
            _buildManagementCard(
              context,
              icon: Icons.library_books_outlined,
              title: "إدارة المكتبة والملفات",
              subtitle: "استعراض وتنظيم ملفات الـ PDF والمقالات",
              onTap: () {
                Get.to(() => LibraryScreen(programId: 1));
              },
            ),
            SizedBox(height: 12.h),
            _buildManagementCard(
              context,
              icon: Icons.bookmark_border_rounded,
              title: "إدارة الفصول والوحدات",
              subtitle: "تقسيم الدورات إلى فصول دراسية منظمة",
              onTap: () {
                Get.to(() => ChapterScreen(programId: 1, libName: 'افتراضي', libID: 1));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: primaryColor, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Janna LT Regular',
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontFamily: 'Janna LT Regular',
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
