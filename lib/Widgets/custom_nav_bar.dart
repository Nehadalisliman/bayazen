// import 'package:e_learning/Models/video_library.dart';
// import 'package:e_learning/Screens/CourseWare/category_screen.dart';
// import 'package:e_learning/Screens/celebrity/profile_techer/pages/editprofile/edit_prfile_page.dart';
// import 'package:e_learning/Screens/old_work/celes_page.dart';
// import 'package:e_learning/Screens/old_work/content_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Screens/celebrity/add_content_screen.dart';
// import '../Screens/home/home_student.dart';
// import '../constants.dart';

// class CustomNavigationBar extends StatelessWidget {
//   final int? index;

//   const CustomNavigationBar({Key? key, this.index}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 70,
//       child: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         fixedColor: primaryColor,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: [
//           BottomNavigationBarItem(
//             label: 'Search',
//             icon: InkWell(
//                 onTap: () {
//                   Get.to(HomeTeacher());
//                 },
//                 child: Icon(
//                   Icons.home,
//                   color: index == 0 ? primaryColor : Color(0xFF7E7E7E),
//                 )),
//           ),
//           BottomNavigationBarItem(
//             label: 'Browse',
//             icon: InkWell(
//                 onTap: () {
//                   Get.to(EditProfilePage());
//                 },
//                 child: Icon(
//                   Icons.group_add,
//                   color: index == 1 ? primaryColor : Color(0xFF7E7E7E),
//                 )),
//           ),
//           BottomNavigationBarItem(
//             label: 'Favorites',
//             icon: InkWell(
//                 onTap: () {
//                   Get.to(AddContentScreen());
//                 },
//                 child: Icon(
//                   Icons.add_circle,
//                   color: index == 2 ? primaryColor : Color(0xFF7E7E7E),
//                 )),
//           ),
//           BottomNavigationBarItem(
//             label: 'Profile',
//             icon: InkWell(
//                 onTap: () {
//                   Get.to(Content());
//                 },
//                 child: Icon(
//                   Icons.video_call_rounded,
//                   color: index == 3 ? primaryColor : Color(0xFF7E7E7E),
//                 )),
//           ),
//           BottomNavigationBarItem(
//             // todo المؤثرين
//             label: 'Profile',
//             icon: InkWell(
//               onTap: () {
//                 Get.to(CelePage());
//               },
//               child: Icon(
//                 Icons.person,
//                 color: index == 4 ? primaryColor : Color(0xFF7E7E7E),
//               ),
//             ),
//           ),
//           // todo  ===== مكتبه الفيديوهات =======
//           BottomNavigationBarItem(
//             label: 'content',
//             icon: InkWell(
//                 onTap: () {
//                   Get.to(LibraryModel2());
//                 },
//                 child: Icon(
//                   Icons.content_paste,
//                   color: index == 5 ? primaryColor : Color(0xFF7E7E7E),
//                 )),
//           ),
//           BottomNavigationBarItem(
//             label: 'course',
//             icon: InkWell(
//                 onTap: () {
//                   Get.to(CategoryScreen());
//                 },
//                 child: Icon(
//                   Icons.comment,
//                   color: index == 6 ? primaryColor : Color(0xFF7E7E7E),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }
