// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/widgets/text_form_field_shared_widget.dart';
import 'package:e_learning/constants.dart';

class EditSpec extends StatefulWidget {
  final CelebController getProfile;

  EditSpec({
    Key? key,
    required this.getProfile,
  }) : super(key: key);

  @override
  State<EditSpec> createState() => _EditSpecState();
}

class _EditSpecState extends State<EditSpec> {
  String? spec;
  final controller = Get.find<CelebController>();
  TextEditingController textEditingController = TextEditingController();
  final ContentController contentController =
      Get.put(ContentController(), permanent: true);

  @override
  void initState() {
    textEditingController.text =
        controller.celebrityResponseModel.specialization!;
    contentController.fetchImageFromServer(
        widget.getProfile.celebrityResponseModel.image ?? '');
    contentController.fetchVideoFromServer(
        widget.getProfile.celebrityResponseModel.personal_vid ?? '');
    super.initState();
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
                title: "التخصص",
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
                  hint: textEditingController.text,
                  controller: textEditingController,
                  textType: TextInputType.name,
                  onChanged: (String newValue) {
                    setState(() {
                      textEditingController.text = newValue;
                      print("$spec");
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
                      log("Data $spec");
                      contentController.updateCelebProfile(
                        spec: textEditingController.text,
                        bio: widget.getProfile.celebrityResponseModel.bio,
                        education:
                            widget.getProfile.celebrityResponseModel.eduction,
                        experience:
                            widget.getProfile.celebrityResponseModel.experience,
                        interests:
                            widget.getProfile.celebrityResponseModel.interests,
                        name: widget.getProfile.celebrityResponseModel.name,
                        personal_vid: contentController.myvideoFile,
                        image1: contentController.myimageFile,
                        skills: widget.getProfile.celebrityResponseModel.skills,
                        context: context

                      );
                    },
                    child: Text(
                      ' حفظ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Janna LT Regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 9.sp),
                    )),
              )
              //SaveButtonWidget(data: spec, modification: 'spec')
            ]),
      ),
    );
  }
}
