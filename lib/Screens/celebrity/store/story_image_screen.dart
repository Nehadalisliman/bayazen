// StoryImageScreen

import 'dart:developer';
import 'dart:io';
import 'package:e_learning/Controllers/celeb/story_controller.dart';
import 'package:e_learning/Screens/celebrity/store/image_viewer.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_text.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StoryImageScreen extends StatefulWidget {
  StoryImageScreen({Key? key}) : super(key: key);

  @override
  State<StoryImageScreen> createState() => _StoryImageScreenState();
}

class _StoryImageScreenState extends State<StoryImageScreen> {
  final desController = TextEditingController();
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

  late StoryController controller;

  @override
  void initState() {
    controller = Get.put(StoryController());
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
              height: 1.sh,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    SizedBox(
                      height: 0.65.sh,
                      child: Card(
                          elevation: 2,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Column(children: [
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
                                  if (value.length < 5000 &&
                                      value.length >= 10) {
                                    return "عنوان المنشور لا يزيد عن 5000 حرف ولا يقل عن 10 احرف";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 0.02.sh,
                            ),
                            SizedBox(
                              height: 0.3.sh,
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
                            ),
                            SizedBox(height: 20.h),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20.w),
                                  IconButton(
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        selectImages();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 38.sp,
                                      )),
                                ]),
                            SizedBox(
                              height: 15.h,
                            )
                          ])),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Obx(() {
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
                            if (_formKey.currentState!.validate()) {
                              log("descriptionController.text${desController.text}");

                              log(" IMagesw.path${imageFileList}");

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
                    }),
                    SizedBox(
                      height: 15.h,
                    )
                  ])))),
    );
  }
}
