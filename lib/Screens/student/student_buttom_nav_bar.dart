import 'package:e_learning/Controllers/student/student_home_controller.dart';
import 'package:e_learning/Screens/student/profile/student_profile.dart';
import 'package:e_learning/Screens/student/home/home_student.dart';
import 'package:e_learning/Screens/student/student_browsing/student_browsing.dart';
import 'package:e_learning/Screens/student/channels_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class StudentBottomNavBar extends StatefulWidget {
  const StudentBottomNavBar({Key? key}) : super(key: key);

  @override
  State<StudentBottomNavBar> createState() => _StudentBottomNavBarState();
}

class _StudentBottomNavBarState extends State<StudentBottomNavBar> {
  final celebcont = Get.put(StudentHomeController());
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeStudent(),
    ChannelsScreen(),
    StudentBrowsing(),
    UpdateStudentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, CupertinoIcons.home, 'الرئيسية'),
            _buildNavItem(1, CupertinoIcons.tv, 'القنوات'),
            _buildNavItem(2, CupertinoIcons.search, 'استكشاف'),
            _buildNavItem(3, CupertinoIcons.person, 'حسابي'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 14.w : 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isSelected ? Colors.white : Colors.grey.shade500,
            ),
            if (isSelected) ...[
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Janna LT Regular',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
