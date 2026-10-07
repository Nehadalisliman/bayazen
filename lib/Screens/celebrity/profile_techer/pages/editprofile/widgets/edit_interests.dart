// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/widgets/text_form_field_shared_widget.dart';
import 'package:e_learning/constants.dart';

import '../../../../../../Controllers/celeb/celeb_controller.dart';

class EditInterests extends StatefulWidget {
  final CelebController getProfile;

  const EditInterests({
    Key? key,
    required this.getProfile,
  }) : super(key: key);

  @override
  State<EditInterests> createState() => _EditInterestsState();
}

class _EditInterestsState extends State<EditInterests> {
  List<String> data = [];

  List<TextEditingController> controllers = [
    TextEditingController(),
  ];
  void addNew() {
    setState(() {
      controllers.add(
        TextEditingController(),
      );
    });
  }

  @override
  void initState() {
    contentController.fetchImageFromServer(
        widget.getProfile.celebrityResponseModel.image ?? '');
    contentController.fetchVideoFromServer(
        widget.getProfile.celebrityResponseModel.personal_vid ?? '');
    super.initState();
  }

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

  final ContentController contentController =
      Get.put(ContentController(), permanent: true);
  final CelebController getProfile = Get.put(CelebController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              title: "الاهتمامات",
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
                height: 60,
                child: TextFormFieldSharedWidget(
                  onValidateListenser: (e) {
                    return "";
                  },
                  controller: controllers[index],
                  label: "",
                  hint: "",
                  textType: TextInputType.name,
                  onChanged: (String newValue) {
                    setState(() {
                      controllers[index].text = newValue;
                    });
                  },
                  initialValue: "",
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                ),
                onPressed: () {
                  sendData();
                  // log
                  log("Data $data");
                  data.removeWhere((element) => element.trim() == "");
                  log("Data $data");
                  if (data.isNotEmpty) {
                    contentController.updateCelebProfile(
                      spec: getProfile.celebrityResponseModel.specialization,
                      bio: getProfile.celebrityResponseModel.bio,
                      education: getProfile.celebrityResponseModel.eduction,
                      experience: getProfile.celebrityResponseModel.experience,
                      image1: contentController.myimageFile,

                      // image1: getProfile.celebrityResponseModel.image,
                      interests: data,
                      name: getProfile.celebrityResponseModel.name,
                      // personal_vid: getProfile.celebrityResponseModel.personal_vid,
                      skills: getProfile.celebrityResponseModel.skills,
                        context: context

                    );
                  }
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
        /*  SaveButtonWidget(
            heigh: 30.h,
            onPressed: () {
              sendData();
              contentController.updateData(
                  data: data, modification: "interests");
            })*/
      ],
    );
  }
}
