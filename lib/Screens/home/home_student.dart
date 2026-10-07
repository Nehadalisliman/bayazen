// // ignore_for_file: must_be_immutable, prefer_const_constructors
// import 'package:e_learning/Controllers/celeb/content_controller.dart';
// import 'package:e_learning/core/global/globalloading.dart';
// import 'package:e_learning/Widgets/custom_nav_bar.dart';
// import '../../Models/home_teacher_response_model.dart';
// import 'package:e_learning/constants.dart';
// import 'package:e_learning/core/helpers/size_config.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// import '../celebrity/library/create_library_screen.dart';

// class HomeTeacher extends StatelessWidget {
//   HomeTeacher({Key? key}) : super(key: key);
//   // SizeConfig sizeConfig = SizeConfig();
//   int? index;
//   bool? isSelected;
//   final ContentController controller = Get.put(ContentController());
//   double? rate;
//   // ignore: unused_field
//   final String _content =
//       'https://play.google.com/store/apps/details?id=com.education.learn';
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     return Scaffold(
//       body: FutureBuilder<HomeResponseModel>(
//         future: ContentController().getHomeContent(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     width: size.width,
//                     height: size.height * .4,
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           top: size.height * .2, right: size.width * .09),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text('اهلا ',
//                               style: TextStyle(
//                                   color: buttonTextColor,
//                                   fontFamily: 'Janna LT Regular',
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold)),
//                           Text(snapshot.data?.firstName! ?? '',
//                               style: TextStyle(
//                                   color: primaryColor,
//                                   fontFamily: 'Janna LT Regular',
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: containerColor.withOpacity(.2),
//                         borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(30),
//                             bottomRight: Radius.circular(30))),
//                   ),
//                   const Align(
//                       alignment: Alignment.topRight,
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 20, top: 15),
//                         child: Text('ماذا سوف تفعل اليوم؟',
//                             style: TextStyle(
//                                 color: accentColor,
//                                 fontFamily: 'Janna LT Regular',
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold)),
//                       )),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       // Container(
//                       //   margin: EdgeInsets.only(top: sizeConfig.height*.05,left: sizeConfig.screenWidth*.03),
//                       //   // ignore: deprecated_member_use
//                       //   child: FlatButton(
//                       //       minWidth: 100,
//                       //       height: 40,
//                       //       color: primaryColor,
//                       //       shape: RoundedRectangleBorder(
//                       //           borderRadius: BorderRadius.circular(10.0)),
//                       //       onPressed: (){
//                       //
//                       //         //  Get.to(ConfirmPassword());
//                       //       }, child: Text(' مشاهده',style: TextStyle(color: buttonTextColor,fontFamily: 'Janna LT Regular',fontWeight: FontWeight.bold,fontSize: 14),)),
//                       // ),
//                       InkWell(
//                         onTap: () {
//                           // Get.to(CreateLibrary());
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(
//                               right: size.width * .1, top: size.height * .05),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 '  ابني مكتبه',
//                                 style: TextStyle(
//                                     color: accentColor,
//                                     fontFamily: 'Janna LT Regular',
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12),
//                               ),
//                               SizedBox(
//                                 width: size.width * .08,
//                               ),
//                               Image.asset('assets/presentation.png')
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       // Container(
//                       //   margin: EdgeInsets.only(top: size.hight*.05,left: sizeConfig.width*.03),
//                       //   // ignore: deprecated_member_use
//                       //   child: FlatButton(
//                       //       minWidth: 100,
//                       //       height: 40,
//                       //       color: primaryColor,
//                       //       shape: RoundedRectangleBorder(
//                       //           borderRadius: BorderRadius.circular(10.0)),
//                       //       onPressed: (){
//                       //         //  Get.to(ConfirmPassword());
//                       //       }, child: Text(' مشاهده ',style: TextStyle(color: buttonTextColor,fontFamily: 'Janna LT Regular',fontWeight: FontWeight.bold,fontSize: 14),)),
//                       // ),
//                       Container(
//                         margin: EdgeInsets.only(
//                             right: size.width * .1, top: size.height * .05),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             InkWell(
//                               child: Text(
//                                 ' المجله',
//                                 style: TextStyle(
//                                     color: accentColor,
//                                     fontFamily: 'Janna LT Regular',
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12),
//                               ),
//                               onTap: () {
//                                 // return buildSpeedDial();
//                               },
//                             ),
//                             SizedBox(
//                               width: size.width * .08,
//                             ),
//                             Image.asset(
//                               'assets/magazine.jpg',
//                               height: 32,
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: size.width,
//                     height: size.height * .2,
//                     child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: snapshot.data?.topFive?.length,
//                         itemBuilder: (context, index) {
//                           return Card(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     children: [
//                                       Text('مدرس',
//                                           style: TextStyle(
//                                               color: primaryColor,
//                                               fontFamily: 'Janna LT Regular',
//                                               fontSize: 13,
//                                               fontWeight: FontWeight.bold)),
//                                       Text(
//                                           snapshot.data?.topFive![index]
//                                                   .name! ??
//                                               '',
//                                           style: TextStyle(
//                                               color: accentColor,
//                                               fontFamily: 'Janna LT Regular',
//                                               fontSize: 13,
//                                               fontWeight: FontWeight.bold)),
//                                       RatingBar.builder(
//                                         initialRating: double.parse(
//                                             '${snapshot.data?.topFive![index].rating}'),
//                                         minRating: 1,
//                                         direction: Axis.horizontal,
//                                         allowHalfRating: true,
//                                         itemCount: 5,
//                                         itemPadding: EdgeInsets.symmetric(
//                                             horizontal: 4.0),
//                                         itemBuilder: (context, _) => Icon(
//                                           Icons.star,
//                                           size: 6,
//                                           color: Colors.amber,
//                                         ),
//                                         onRatingUpdate: (rating) {},
//                                       ),

//                                       // Row(
//                                       //   children: [
//                                       //     Icon(Icons.star_border_outlined,color: primaryColor,),
//                                       //     Icon(Icons.star,color: primaryColor,),
//                                       //     Icon(Icons.star,color: primaryColor,),
//                                       //     Icon(Icons.star,color: primaryColor,),
//                                       //     Icon(Icons.star,color: primaryColor,)
//                                       //   ],
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                                 ClipRRect(
//                                     borderRadius: BorderRadius.circular(20),
//                                     child: Image.asset(
//                                       'assets/teacher.jpg',
//                                       width: 100,
//                                     ))
//                               ],
//                             ),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20)),
//                             elevation: 3,
//                           );
//                         }),
//                   )
//                 ],
//               ),
//             );
//           } else {
//             return GlobalLoading();
//           }
//         },
//       ),
//       bottomNavigationBar: CustomNavigationBar(
//         index: 0,
//       ),
//     );
//   }
// }
