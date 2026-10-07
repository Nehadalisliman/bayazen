// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/editprofile/widgets/save_button.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/pages/profilePage/widgets/profile_section2_widgets.dart';
import 'package:e_learning/Screens/celebrity/profile_techer/widgets/text_form_field_shared_widget.dart';

import '../../../../../../Controllers/celeb/celeb_controller.dart';

class EditEducation extends StatefulWidget {
  final CelebController getProfile;
  const EditEducation({
    Key? key,
    required this.getProfile,
  }) : super(key: key);
  @override
  EditEducationState createState() => EditEducationState();
}

class EditEducationState extends State<EditEducation> {
  List<String> years = [
    "1970",
    "1971",
    "1972",
    "1973",
    "1974",
    "1975",
    "1976",
    "1977",
    "1978",
    "1979",
    "1980",
    "1981",
    "1982",
    "1983",
    "1984",
    "1985",
    "1986",
    "1987",
    "1988",
    "1989",
    "1990",
    "1991",
    "1992",
    "1993",
    "1994",
    "1995",
    "1996",
    "1997",
    "1998",
    "1999",
    "2000",
    "2001",
    "2002",
    "2003",
    "2004",
    "2005",
    "2006",
    "2007",
    "2008",
    "2009",
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "حتي الان"
  ];

  Widget customDropDown(
      BuildContext context, String hint, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ]),
      child: Stack(
        children: [
          Positioned(
            // right: 5,
            top: 5,
            left: 5,
            bottom: 5,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    isExpanded: true,
                    items: List.generate(
                        years.length,
                        (index) => DropdownMenuItem<String>(
                            value: years[index], child: Text(years[index]))),
                    onChanged: (value) => controller.text = value!),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormFieldSharedWidget(
                  hint: hint,
                  label: hint,
                  controller: controller,
                  // hint: hint,
                  textType: TextInputType.name,
                  onChanged: (String newValue) {},

                  initialValue: "",
                ),
              ),
              const SizedBox.square(dimension: 48.0)
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    try {
      contentController.dispose();
    } catch (w) {}
    super.dispose();
  }

  void addNewExp() {
    setState(() {
      controllers.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
    });
  }

  List<List<String>> data = [];

  List<List<TextEditingController>> controllers = [
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ]
  ];

  sendData() {
    setState(() {
      data.clear();
      controllers.forEach((element) {
        data.add([
          element[0].text.toString(),
          element[1].text.toString(),
          element[2].text.toString(),
          element[3].text.toString(),
        ]);

        log(data.toString());
      });
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

  final ContentController contentController =
      Get.put(ContentController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "تعديل التعليم",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontFamily: appFont,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: ListView(
          children: [
            // IconButton(
            //   onPressed: () {
            //     addNewExp();
            //   },
            //   icon: Icon(
            //     Icons.add_circle,
            //     size: 23.sp,
            //     color: Colors.blue,
            //   ),
            // ),
            ...List.generate(controllers.length, (index) {
              return SizedBox(
                height: 320.h,
                child: Column(children: [
                  CustomTextWidget(
                    title: "التعليم",
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
                  SizedBox(
                    height: 60.h,
                    child: TextFormFieldSharedWidget(
                      onValidateListenser: (e) {
                        return "";
                      },
                      hint: "الكليه",
                      controller: controllers[index][0],
                      label: "الكليه",
                      textType: TextInputType.name,
                      onChanged: (String newValue) {
                        setState(() {
                          controllers[index][0].text = newValue;
                        });
                      },
                      initialValue: "",
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  SizedBox(
                    height: 60.h,
                    child: TextFormFieldSharedWidget(
                      onValidateListenser: (e) {
                        return "";
                      },
                      hint: "التخصص",
                      controller: controllers[index][1],
                      label: "التخصص",
                      textType: TextInputType.name,
                      onChanged: (String newValue) {
                        setState(() {
                          controllers[index][1].text = newValue;
                        });
                      },
                      initialValue: "",
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  SizedBox(
                    height: 60.h,
                    child: customDropDown(
                        context, "سنه البدايه", controllers[index][2]),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  SizedBox(
                    height: 60.h,
                    child: customDropDown(
                        context, "سنه النهايه", controllers[index][3]),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                ]),
              );
            }),
            SaveButtonWidget(
              heigh: 40.h,
              data: '',
              modification: "experience",
              onPressed: () {
                sendData();
                contentController.updateCelebProfile(
                    education: data.map((e) => e.map((e) => e)).toList(),
                    spec:
                        widget.getProfile.celebrityResponseModel.specialization,
                    bio: widget.getProfile.celebrityResponseModel.bio,
                    experience:
                        widget.getProfile.celebrityResponseModel.experience,
                    interests:
                        widget.getProfile.celebrityResponseModel.interests,
                    name: widget.getProfile.celebrityResponseModel.name,
                    skills: widget.getProfile.celebrityResponseModel.skills,
                    image1: contentController.myimageFile,
                    personal_vid: contentController.myvideoFile,
                    context: context);
                // contentController.updateData(
                //     data: data, modification: "education");
              },
            ),
            SizedBox(
              height: 15.sp,
            ),
          ],
        ),
      ),
    );
  }
}
