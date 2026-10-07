// import 'package:e_learning/Widgets/app_color.dart';
// import 'package:e_learning/core/helpers/size_config.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../home/home_student.dart';
// import 'identification_screen.dart';
// import 'package:flutter/material.dart';

// class StartScreen extends StatefulWidget {
//   const StartScreen({Key? key}) : super(key: key);

//   @override
//   _StartScreenState createState() => _StartScreenState();
// }

// class _StartScreenState extends State<StartScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   Animation? animation;

//   _startNextScreen() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var token = preferences.getString('token');

//     /// check if  user has sign in before
//     if (token != null) {
//       print(token);

//       Get.to(HomeTeacher());
//     } else {
//       // Get.offAll(const AppRetainWidget(child: OnBoardingScreen()));
//       Get.offAll(const IdentificationScreen());
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration.zero, _startNextScreen);
//     controller = AnimationController(
//       duration: const Duration(seconds: 5), vsync: this, //    upperBound: 100.0
//     );
//     animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
//     controller.forward();

//     controller.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       body: Container(
//         width: SizeConfig().blockSizeHorizontal() * 100,
//         height: SizeConfig().blockSizeVertical() * 100,
//         decoration: BoxDecoration(),
//         child: Center(
//           child: Hero(
//             tag: 'logo1',
//             child: Material(
//               color: Colors.transparent,
//               elevation: 20.0,
//               borderOnForeground: false,
//               borderRadius: BorderRadius.circular(4.0),
//               shadowColor: AppColor.primaryColor.withOpacity(0.1),
//               child: SizedBox(
//                   height: 120,
//                   //height: animation.value !=null?animation.value*120:0,
//                   child: Image.asset(
//                     'assets/logo1.png',
//                     fit: BoxFit.contain,
//                   )),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
