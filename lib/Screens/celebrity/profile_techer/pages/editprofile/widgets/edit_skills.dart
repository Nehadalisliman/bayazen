// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/widgets/text_form_field_shared_widget.dart';
import 'package:e_learning/constants.dart';

import '../../../../../../Controllers/celeb/celeb_controller.dart';

class EditSkills extends StatefulWidget {
  final CelebController getProfile;

  const EditSkills({
    Key? key,
    required this.getProfile,
  }) : super(key: key);

  @override
  State<EditSkills> createState() => _EditSkillsState();
}

class _EditSkillsState extends State<EditSkills> {
  @override
  void initState() {
    contentController.fetchImageFromServer(
        widget.getProfile.celebrityResponseModel.image ?? '');
    contentController.fetchVideoFromServer(
        widget.getProfile.celebrityResponseModel.personal_vid ?? '');

    data = widget.getProfile.celebrityResponseModel.skills!;
    super.initState();
  }

  void addNew() {
    setState(() {
      controllers.add(
        TextEditingController(),
      );
    });
  }

  List<String> data = [];

  List<TextEditingController> controllers = [
    TextEditingController(),
  ];

  sendData() {
    setState(() {
      data.clear();
      controllers.forEach((element) {
        data.add(
          element.text.toString(),
        );

        log(data.toString());
      });
    });
  }

  final ContentController contentController = Get.put(ContentController());
  @override
  Widget build(BuildContext context) {
    print(widget.getProfile.celebrityResponseModel.skills);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              title: "المهارات",
              titleTextStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
                color: Colors.grey,
                fontFamily: appFont,
              ),
            ),
            IconButton(
              onPressed: () {
                addNew();
              },
              icon: Icon(
                Icons.add_circle,
                size: 25.sp,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        ...List.generate(controllers.length, (index) {
          return Column(
            children: [
              SizedBox(
                height: 60.h,
                child: TextFormFieldSharedWidget(
                  controller: controllers[index],
                  onValidateListenser: (p0) {
                    return "";
                  },
                  label: "",
                  hint: data.join("،"),
                  textType: TextInputType.name,
                  onChanged: (String newValue) {
                    setState(() {
                      controllers[index].text = newValue;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 6.sp,
              )
            ],
          );
        }),
        const SizedBox(height: 20),
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
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              ),
              onPressed: () {
                // sendData();
                print(controllers.map((e) => e.text).toList());
                // log
                // data.removeWhere((element) => element.trim() == "");
                // log("Data $data");
                // if (data.isNotEmpty) {
                contentController.updateCelebProfile(
                  skills: controllers.map((e) => e.text).toList(),
                  spec: widget.getProfile.celebrityResponseModel.specialization,
                  bio: widget.getProfile.celebrityResponseModel.bio,
                  education: widget.getProfile.celebrityResponseModel.eduction,
                  experience:
                      widget.getProfile.celebrityResponseModel.experience,
                  interests: widget.getProfile.celebrityResponseModel.interests,
                  name: widget.getProfile.celebrityResponseModel.name,
                  personal_vid: contentController.myvideoFile,
                  image1: contentController.myimageFile,
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
        /* SaveButtonWidget(
            heigh: 30.h,
            onPressed: () {
              sendData();
              contentController.updateData(data: data, modification: "skills");
            })*/
      ],
    );
  }
}
