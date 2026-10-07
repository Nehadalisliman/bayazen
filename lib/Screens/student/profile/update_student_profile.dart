import 'dart:io';

import 'package:e_learning/Controllers/student/student_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/app_color.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Controllers/celeb/content_controller.dart';

// ignore: must_be_immutable
class UpdateProfile extends StatefulWidget {
  final String? name;
  final String? image;
  final String? occupation;
  final String? bio;
  final String? email;
  final String? phone;

  UpdateProfile(
      {Key? key,
      this.name,
      this.image,
      this.occupation,
      this.bio,
      this.email,
      this.phone})
      : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  //final String password;
  String errorMessage = "";

  final nameController = TextEditingController();

  final occupationController = TextEditingController();

  final bioController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();
  final imageController = TextEditingController();

  StudentController controller = Get.put(StudentController());
  final ContentController contentController = Get.put(ContentController());
  @override
  void initState() {
    super.initState();
    controller.fetchImageFromServer(widget.image ?? '');
    nameController.text = widget.name ?? "";
    occupationController.text = widget.occupation ?? '';
    bioController.text = widget.bio ?? '';
    emailController.text = widget.email ?? '';
    phoneController.text = widget.phone ?? '';
    imageController.text = widget.image ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    occupationController.dispose();
    bioController.dispose();
    emailController.dispose();
    phoneController.dispose();
    imageController.dispose();
    super.dispose();
  }

  Text labelWidget(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
          fontFamily: 'Janna LT Regular'),
    );
  }

  File? fileImage;

  pikImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        fileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          elevation: 0,
          title: Text(
            "الصفحه الشخصيه",
            style: TextStyle(
                color: AppColor.appBarColor,
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                fontFamily: 'Janna LT Regular'),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.appBarColor,
              ),
              onPressed: () {
                Get.back();
              }),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250.h,
                  color: AppColor.containerColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      fileImage != null
                          ? CircleAvatar(
                              radius: 50.r,
                              backgroundColor: AppColor.whiteColor,
                              backgroundImage: FileImage(fileImage!),
                            )
                          : CircleAvatar(
                              radius: 50.r,
                              backgroundColor: AppColor.whiteColor,
                              backgroundImage: NetworkImage(widget.image!),
                            ),
                      SizedBox(
                        height: 15.h,
                      ),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0.r),
                              ))),
                          onPressed: () async {
                            await pikImage();
                          },
                          child: Text(
                            "اختيار صوره",
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: 'Janna LT Regular',
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 1.h,
                      ),
                      Obx(() {
                        if (controller.isProfileUpdateLoading.value) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        }
                        return TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0.r),
                                ))),
                            onPressed: () async {
                              controller.updateStudentProfileImage(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                                occupation: occupationController.text,
                                bio: bioController.text,
                                imageFile: fileImage?.path ??
                                    controller.imageFileStudent?.path,
                              );
                            },
                            child: Text(
                              "حفظ",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: 'Janna LT Regular',
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ));
                      }),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10.h,
                ),

                Padding(
                  padding: EdgeInsets.all(12.0.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelWidget("الاسم"),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomTextField(
                        hintText: 'الاسم',
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      labelWidget("الايميل"),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomTextField(
                        hintText: 'الايميل',
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      labelWidget("الرقم"),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomTextField(
                        hintText: 'الرقم',
                        controller: phoneController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      labelWidget("كلمه المرور"),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomTextField(
                        hintText: 'كلمه المرور',
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      labelWidget("المهنه"),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomTextField(
                        hintText: 'المهنه',
                        controller: occupationController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      labelWidget("السيره الذاتيه"),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomTextField(
                        hintText: 'Bio',
                        controller: bioController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // ignore: deprecated_member_use
                Obx(() {
                  if (controller.isProfileUpdateLoading.value) {
                    return GlobalLoading();
                  }

                  return TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0.r),
                          ))),
                      onPressed: () async {
                        print(widget.image);

                        controller.updateStudentProfileImage(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          password: passwordController.text,
                          occupation: occupationController.text,
                          bio: bioController.text,
                          imageFile: fileImage?.path ??
                              controller.imageFileStudent?.path,
                        );
                      },
                      child: Text(
                        "تعديل الملف الشخصي",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Janna LT Regular',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ));
                }),

                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ));
  }
}
