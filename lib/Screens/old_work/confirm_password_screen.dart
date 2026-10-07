// import 'package:e_learning/Widgets/custom_text_field.dart';
// import 'package:e_learning/constants.dart';
// import 'package:flutter/material.dart';
//
// class ConfirmPassword extends StatelessWidget {
//   const ConfirmPassword({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: backgroundColor,
//       body: SafeArea(
//           child: Column(
//             children: [
//               Image.asset('assets/logo.png',height: 150,) ,
//               Text(' تغيير الباسورد',style: TextStyle(color: accentColor,fontFamily: 'Janna LT Regular',fontSize: 15,fontWeight: FontWeight.bold),),
//               Form(
//                 child: Column(
//                   children: [
//                     Container(
//                       child: CustomTextField(hintText: 'الرقم السري',),margin: EdgeInsets.only(top: 20),),
//                     Container(
//                       child: CustomTextField(hintText: 'تاكيد الرقم السري',),margin: EdgeInsets.only(top: 20),),
//                     Container(
//                       margin: EdgeInsets.only(top: 25),
//                       child: FlatButton(
//                           minWidth: 350,
//                           height: 60,
//                           color: primaryColor,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                           onPressed: (){
//                             // Get.to(Home());
//                           }, child: Text(' تاكيد',style: TextStyle(color: buttonTextColor,fontFamily: 'Janna LT Regular',fontWeight: FontWeight.bold,fontSize: 18),)),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           )),
//     );
//
//   }
// }
