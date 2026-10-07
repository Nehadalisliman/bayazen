import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Screens/celebrity/browsing/celeb_browsing.dart';
import 'package:e_learning/Screens/celebrity/celebrity_profile.dart';
import 'package:e_learning/Screens/home/home_celeb.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/profile_details_page.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class CelebBottomNavBar extends StatefulWidget {
  const CelebBottomNavBar({Key? key}) : super(key: key);

  @override
  State<CelebBottomNavBar> createState() => _CelebBottomNavBarState();
}

class _CelebBottomNavBarState extends State<CelebBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeCeleb(),
    CelebBrowsing(),
    ProfileDetailsPage(),
  ];

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<CelebController>()) {
      Get.put(CelebController());
    }
  }

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
            _buildNavItem(1, CupertinoIcons.square_list, 'الإدارة'),
            _buildNavItem(2, CupertinoIcons.person_crop_circle, 'حسابي'),
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
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 16.w : 12.w, vertical: 8.h),
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
