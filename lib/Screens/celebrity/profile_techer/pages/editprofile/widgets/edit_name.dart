// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/widgets/text_form_field_shared_widget.dart';
import 'package:e_learning/constants.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../Controllers/celeb/celeb_controller.dart';

class EditName extends StatefulWidget {
  final CelebController getProfile;
  final String? name;
  EditName({
    Key? key,
    required this.getProfile,
    this.name,
  }) : super(key: key);

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  String? _name;
  String profilePhoto = '';

  TextEditingController _nameController = TextEditingController();
  final ContentController contentController = Get.put(ContentController());
  // final CelebController getProfile = Get.put(CelebController());
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name ?? '';
    contentController.fetchImageFromServer(
        widget.getProfile.celebrityResponseModel.image ?? '');
    contentController.fetchVideoFromServer(
        widget.getProfile.celebrityResponseModel.personal_vid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: StatefulBuilder(
        builder: (cnx, setState) => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextWidget(
                title: "اكتب الاسم",
                titleTextStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey,
                  fontFamily: appFont,
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              SizedBox(
                height: 60.h,
                child: TextFormFieldSharedWidget(
                  label: "",
                  hint: "",
                  controller: _nameController,
                  textType: TextInputType.name,
                  onChanged: (String newValue) {
                    setState(() {
                      _name = newValue;
                      print("$_name");
                    });
                  },
                  initialValue: "",
                ),
              ),
              const SizedBox(height: 10),
              //  ? Save Button Widget

              Container(
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.sp),
                    color: Colors.blue,
                  ),
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                      ),
                      onPressed: () {
                        // log
                        // profilePhoto = File(
                        //     widget.getProfile.celebrityResponseModel.image);
                        ;
                        print(_name);
                        log("Data ${widget.getProfile.celebrityResponseModel.image}");
                        log("Data ${widget.getProfile.celebrityResponseModel.personal_vid}");
                        contentController.updateCelebProfile(
                            spec: widget.getProfile.celebrityResponseModel
                                .specialization,
                            bio: widget.getProfile.celebrityResponseModel.bio,
                            education: widget
                                .getProfile.celebrityResponseModel.eduction,
                            experience: widget
                                .getProfile.celebrityResponseModel.experience,
                            interests: widget
                                .getProfile.celebrityResponseModel.interests,
                            name: _nameController.text,
                            image1: contentController.myimageFile,
                            personal_vid: contentController.myvideoFile,
                            skills:
                                widget.getProfile.celebrityResponseModel.skills,
                            context: context);
                      },
                      child: Text(
                        ' حفظ',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Janna LT Regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 9.sp),
                      )))

              //SaveButtonWidget(data: _name, modification: 'name')
            ]),
      ),
    );
  }
}
