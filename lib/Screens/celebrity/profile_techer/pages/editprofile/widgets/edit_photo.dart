// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/core/helpers/size_config.dart';

import '../../../../../../Controllers/celeb/celeb_controller.dart';

class EditPhoto extends StatefulWidget {
  final CelebController getProfile;

  EditPhoto({
    Key? key,
    required this.getProfile,
  }) : super(key: key);

  @override
  State<EditPhoto> createState() => _EditPhotoState();
}

class _EditPhotoState extends State<EditPhoto> {
  SizeConfig sizeConfig = SizeConfig();

  final ContentController contentController = Get.put(ContentController());

  File? imageFile;
  PlatformFile? _file;

  // VideoPlayerController _videoPlayerController;

/*  _pickVideo() async {
    final videoo = await video.pickVideo(source: ImageSource.gallery);
    _file = PlatformFile(path: videoo.path);
    setState(() {
      progress = _file.size.toDouble();
    });*/

  void _pickFile() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _file = PlatformFile(path: image!.path, name: image.path, size: 10);
      imageFile = File(image.path);
    });
  }

  @override
  void initState() {
    contentController.fetchVideoFromServer(
        widget.getProfile.celebrityResponseModel.personal_vid ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(children: [
          CustomTextWidget(
            title: "تعديل الصوره",
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
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey[200],
            backgroundImage: ((imageFile != null)
                ? FileImage(imageFile!)
                : widget.getProfile.celebrityResponseModel.image ==
                        "https://elbyazin-s3.s3.me-south-1.amazonaws.com/images/celebs/profile/def_avatar.png"
                    ? Image.asset('assets/user.png').image
                    : Image.network(
                            widget.getProfile.celebrityResponseModel.image!)
                        .image),
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
              onPressed: () {
                _pickFile();
              },
              child: Text(
                "تحميل",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: appFont,
                  color: Colors.white,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                ),
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
                  log("_file" + imageFile!.path);
                  contentController.updateCelebProfile(
                      spec: widget
                          .getProfile.celebrityResponseModel.specialization,
                      bio: widget.getProfile.celebrityResponseModel.bio,
                      education:
                          widget.getProfile.celebrityResponseModel.eduction,
                      experience:
                          widget.getProfile.celebrityResponseModel.experience,
                      interests:
                          widget.getProfile.celebrityResponseModel.interests,
                      name: widget.getProfile.celebrityResponseModel.name,
                      skills: widget.getProfile.celebrityResponseModel.skills,
                      personal_vid: widget.getProfile.celebrityResponseModel
                                  .personal_vid !=
                              ""
                          ? contentController.myvideoFile
                          : widget
                              .getProfile.celebrityResponseModel.personal_vid,
                      image1: File(_file!.path!),
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
          //   // if (contentController.isImageUpdateLoading.value) {
          //   //   return Center(child: CircularProgressIndicator());
          //   // }
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
          //           log("_file" + imageFile!.path);
          //           showLoader(context);
          //           contentController.updateCelebProfile(
          //             spec: widget
          //                 .getProfile.celebrityResponseModel.specialization,
          //             bio: widget.getProfile.celebrityResponseModel.bio,
          //             education:
          //                 widget.getProfile.celebrityResponseModel.eduction,
          //             experience:
          //                 widget.getProfile.celebrityResponseModel.experience,
          //             interests:
          //                 widget.getProfile.celebrityResponseModel.interests,
          //             name: widget.getProfile.celebrityResponseModel.name,
          //             skills: widget.getProfile.celebrityResponseModel.skills,
          //             personal_vid: widget.getProfile.celebrityResponseModel
          //                         .personal_vid !=
          //                     ""
          //                 ? contentController.myvideoFile
          //                 : widget
          //                     .getProfile.celebrityResponseModel.personal_vid,
          //             image1: imageFile,
          //           );
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

          // })
        ]));
  }
}
