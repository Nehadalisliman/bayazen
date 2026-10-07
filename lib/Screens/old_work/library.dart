// import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
// import 'package:e_learning/Models/video_library.dart';
// import 'package:e_learning/Screens/old_work/upload.dart';
// import 'package:e_learning/Widgets/custom_nav_bar.dart';
// import 'package:e_learning/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Library extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('مكتبه الفيديوهات ',
//             style: TextStyle(
//                 color: accentColor,
//                 fontFamily: 'Janna LT Regular',
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold)),
//         leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: const Icon(
//               Icons.arrow_back,
//               color: accentColor,
//             )),
//         backgroundColor: buttonTextColor,
//       ),
//       body: FutureBuilder<dynamic>(
//         future: CelebController().getLibraries(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: snapshot.data!.libraries!.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: InkWell(
//                           onTap: () async {
//                             Get.offAll(Upload(
//                               library_title:
//                                   snapshot.data!.libraries![index].title,
//                             ));
//                           },
//                           child: Card(
//                             color: primaryColor,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: Container(
//                                 height: 100,
//                                 width: double.infinity,
//                                 child: Center(
//                                     child: Text(
//                                   '${snapshot.data!.libraries![index].title}',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 ))),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 });
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       bottomNavigationBar: CustomNavigationBar(
//         index: 5,
//       ),
//     );
//   }
// }
