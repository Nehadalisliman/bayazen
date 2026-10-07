// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:e_learning/Widgets/vedio_item.dart';
import 'package:e_learning/constants.dart';

import '../../../../../../Controllers/celeb/celeb_controller.dart';

class EditVideo extends StatefulWidget {
  final CelebController getProfile;
  EditVideo({
    Key? key,
    required this.getProfile,
  }) : super(key: key);

  @override
  State<EditVideo> createState() => _EditVideoState();
}

class _EditVideoState extends State<EditVideo> {
  File? _video;

  PlatformFile? _file;

  VideoPlayerController? _videoPlayerController;

  final ContentController contentController =
      Get.put(ContentController(), permanent: true);

  final picker = ImagePicker();

  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    contentController.fetchImageFromServer(
        widget.getProfile.celebrityResponseModel.image ?? '');
  }

  @override
  void dispose() {
    // videoPlayerController.pause();
    super.dispose();
  }

  pikVideo() async {
    await FilePicker.platform.pickFiles(type: FileType.video).then((value) {
      _file = value!.files.first;
      _video = File(_file!.path!);
      log(_video!.path);
      setState(() {});
    });
    videoPlayerController = VideoPlayerController.file(_video!);
    videoPlayerController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, setState) {
      return Column(
        children: [
          CustomTextWidget(
            title: "تعديل الفيديو التعريفي",
            titleTextStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w900,
              color: Colors.grey,
              fontFamily: appFont,
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          (_video == null)
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade300,
                  ),
                  height: 150.h,
                  child: Center(
                    child: IconButton(
                        color: Colors.blueAccent,
                        onPressed: () async {
                          await pikVideo();
                        },
                        icon: Icon(Icons.cloud_upload_outlined)),
                  ),
                )
              : Directionality(
                  textDirection: TextDirection.ltr,
                  child: SizedBox(
                    height: 200.h,
                    width: double.infinity,
                    child: VideoItems(
                      videoPlayerController:
                          VideoPlayerController.network(_video!.path),
                      width: double.infinity,
                    ),
                  ),
                ),
          SizedBox(
            height: 10.sp,
          ),
          Container(
            height: 30.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.blue,
            ),
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                ),
                onPressed: () {
                  // log
                  log("_file" + _file!.path.toString());
                  contentController.updateCelebProfile(
                      spec: widget
                          .getProfile.celebrityResponseModel.specialization,
                      bio: widget.getProfile.celebrityResponseModel.bio,
                      education:
                          widget.getProfile.celebrityResponseModel.eduction,
                      experience:
                          widget.getProfile.celebrityResponseModel.experience,
                      image1: contentController.myimageFile,
                      interests:
                          widget.getProfile.celebrityResponseModel.interests,
                      name: widget.getProfile.celebrityResponseModel.name,
                      personal_vid: File(_file!.path!),
                      skills: widget.getProfile.celebrityResponseModel.skills,
                      context: context);
                },
                child: Text(
                  ' حفظ',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Janna LT Regular',
                      fontWeight: FontWeight.bold,
                      fontSize: 9.sp),
                )),
          ),

          // Obx(() {
          //   if (contentController.isVideoUploading.value) {
          //     return Center(
          //         child: Row(
          //       children: [
          //         IconButton(
          //             onPressed: () {
          //               contentController.cancelUpdate();
          //             },
          //             icon: Icon(
          //               Icons.cancel,
          //               color: Colors.red,
          //             )),
          //         Text(
          //           'جاري رفع الفيديو' +
          //               "    " +
          //               contentController.uploadVideoString.value,
          //           style: TextStyle(
          //             fontSize: 14.sp,
          //             fontWeight: FontWeight.w900,
          //             color: Colors.black45,
          //             fontFamily: appFont,
          //           ),
          //         ),
          //         SizedBox(
          //           width: 20.w,
          //         ),
          //         CircularProgressIndicator(
          //           strokeWidth: 2,
          //         ),
          //       ],
          //     ));
          //   }
          //   return Container(
          //     height: 30.h,
          //     width: 100.w,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(13),
          //       color: Colors.blue,
          //     ),
          //     child: TextButton(
          //         style: ButtonStyle(
          //           backgroundColor:
          //               MaterialStateProperty.all<Color>(primaryColor),
          //         ),
          //         onPressed: () {
          //           // log
          //           log("_file" + _file!.path.toString());
          //           contentController.updateCelebProfile(
          //               spec: widget
          //                   .getProfile.celebrityResponseModel.specialization,
          //               bio: widget.getProfile.celebrityResponseModel.bio,
          //               education:
          //                   widget.getProfile.celebrityResponseModel.eduction,
          //               experience:
          //                   widget.getProfile.celebrityResponseModel.experience,
          //               image1: contentController.myimageFile,
          //               interests:
          //                   widget.getProfile.celebrityResponseModel.interests,
          //               name: widget.getProfile.celebrityResponseModel.name,
          //               personal_vid2: File(_file!.path!),
          //               skills: widget.getProfile.celebrityResponseModel.skills,
          //               context: context);
          //         },
          //         child: Text(
          //           ' حفظ',
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontFamily: 'Janna LT Regular',
          //               fontWeight: FontWeight.bold,
          //               fontSize: 9.sp),
          //         )),
          //   );

          // }),
          SizedBox(
            height: 20.h,
          ),
        ],
      );
    });
  }
}
