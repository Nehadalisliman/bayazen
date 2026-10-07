import 'dart:developer';
import 'dart:io';

import 'package:e_learning/Controllers/celeb/story_controller.dart';
import 'package:e_learning/Screens/celebrity/store/image_viewer.dart';
import 'package:e_learning/Screens/celebrity/store/video_story.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_text.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final desController = TextEditingController();
  File? _video;

  late StoryController controller;
  final picker = ImagePicker();

  File? image;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList.length.toString());
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = Get.put(StoryController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: customText(
            text: "رفع منشور",
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.3.sh,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(children: [
                    Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: CustomTextField(
                            controller: desController,
                            hintText: 'ما اللذي يدور في ذهنك',
                            maxLines: 5,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "برجاء ادخال عنوان المنشور ";
                              }
                              if (value.length <= 10) {
                                return "عنوان المنشور لا يقل عن 10 احرف";
                              }
                              if (value.length > 5000) {
                                return "عنوان المنشور لا يزيد عن 5000 حرف";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        StatefulBuilder(
                            builder: (BuildContext context, setTState) {
                          if (_video == null) {
                            return SizedBox(
                              height: 180.h,
                              width: double.infinity,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                      itemCount: imageFileList.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.all(5.r),
                                          child: Container(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(ImageViewer(
                                                      imageProvider: FileImage(
                                                          File(imageFileList[
                                                                  index]
                                                              .path))));
                                                },
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  image: DecorationImage(
                                                      image: FileImage(File(
                                                          imageFileList[index]
                                                              .path)),
                                                      fit: BoxFit.cover))),
                                        );
                                      })),
                            );
                          }
                          return Directionality(
                            textDirection: TextDirection.ltr,
                            child: VideoStory(
                              videoUrl: _video!.path,
                            ),
                          );
                        }),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(width: 20.w),
                      IconButton(
                          color: Colors.blueAccent,
                          onPressed: () async {
                            // todo   صوره
                            setState(() {
                              _video = null;
                              imageFileList = [];
                            });
                            selectImages();
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 38.sp,
                          )),
                      SizedBox(width: 20.w),
                      IconButton(
                          color: Colors.blueAccent,
                          onPressed: () async {
                            // todo   فيديو
                            setState(() {
                              _video = null;
                            });
                            final video = (await picker.pickVideo(
                                source: ImageSource.gallery))!;
                            _video = File(video.path);
                            setState(() {
                              _video = File(video.path);
                              imageFileList = [];
                            });
                          },
                          icon: Icon(
                            Icons.video_file,
                            size: 38.sp,
                          )),
                    ]),
                    SizedBox(
                      height: 20.h,
                    )
                  ]),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                (_video == null)
                    ? Obx(() {
                        if (controller.isImagesUploading.value) {
                          return Center(
                              child: Container(
                            height: 150.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade300,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await controller.cancleUpladImagesFunc();
                                    },
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                      size: 30.sp,
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "جاري رفع منشورك",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      controller.uploadImagesString.value,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 25.sp,
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              ],
                            ),
                          ));
                        }

                        return customElevatedButton(
                            text: 'نشر',
                            onPressed: () async {
                              RxBool imageSizeValid = true.obs;
                              imageFileList.firstWhereOrNull((imageX) {
                                File image = File(imageX.path);
                                int sizeInBytes = image.lengthSync();
                                double sizeInMb = sizeInBytes / (1024 * 1024);
                                log("sizeInMb ${sizeInMb}");
                                if (sizeInMb > 2) {
                                  FlashHelper().errorBar(
                                      duration: Duration(seconds: 4),
                                      message:
                                          "يجب ان يكون حجم الصوره اقل من 2 ميجا");
                                  imageSizeValid.value = false;
                                  return true;
                                }

                                return false;
                              });

                              if (_formKey.currentState!.validate()) {
                                log("descriptionController.text${desController.text}");

                                log(" IMagesw.path${imageFileList}");
                                if (!imageSizeValid.value) {
                                  return;
                                }

                                await controller.uploadImages(
                                  description: desController.text,
                                  images: imageFileList,
                                );
                                setState(() {
                                  imageFileList = [];
                                  desController.clear();
                                });
                              }
                            });
                      })
                    : Obx(() {
                        if (controller.isVideoUploading.value) {
                          return Center(
                              child: Container(
                            height: 150.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade300,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                // IconButton(
                                //     onPressed: () async {
                                //       await controller.cancelUpload();
                                //     },
                                //     icon: Icon(
                                //       Icons.cancel_outlined,
                                //       color: Colors.red,
                                //       size: 30.sp,
                                //     )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "جاري رفع منشورك",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 25.sp,
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              ],
                            ),
                          ));
                        }

                        return customElevatedButton(
                            text: 'نشر',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                log("descriptionController.text${desController.text}");

                                log("  _video.path${_video!.path}");

                                await controller.uploadStory(
                                  description: desController.text,
                                  videoPath: _video?.path ?? '',
                                  images: imageFileList ?? [],
                                );
                                setState(() {
                                  _video = null;
                                  desController.clear();
                                });
                              }
                            }
                            // onPressed: () async {
                            //   if (_video == null) {
                            //     FlashHelper().errorBar(
                            //         duration: Duration(seconds: 4),
                            //         message: "برجاء رفع محتوي");
                            //     return;
                            //   }
                            //   if (_video != null) {
                            //     log("Video");
                            //     log("  _video.path${_video!.path}");
                            //     bool mp4 = _video!.path.contains("MP4") ||
                            //         _video!.path.contains("mp4");
                            //     if (!mp4) {
                            //       FlashHelper().errorBar(
                            //           duration: Duration(seconds: 4),
                            //           message: "يجب ان يكون الفيديو بصيغة mp4");
                            //       return;
                            //     } else {
                            //       int sizeInBytes = _video!.lengthSync();
                            //       double sizeInMb = sizeInBytes / (1024 * 1024);
                            //       if (sizeInMb > 100) {
                            //         FlashHelper().errorBar(
                            //             duration: Duration(seconds: 4),
                            //             message:
                            //                 "يجب ان يكون حجم الفيديو اقل من 100 ميجا");
                            //         return;
                            //       }
                            //     }
                            //   }
                            //   if (_formKey.currentState!.validate()) {
                            //     log("descriptionController.text${desController.text}");
                            //     log("  _video.path${_video!.path}");
                            //     await controller.uploadStory(
                            //       description: desController.text,
                            //       videoPath: _video!.path,
                            //     );
                            //     setState(() {
                            //       _video = null;
                            //       desController.clear();
                            //     });
                            //   }
                            // },
                            );
                      }),
                SizedBox(
                  height: 15.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
