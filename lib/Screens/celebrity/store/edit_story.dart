import 'package:e_learning/Controllers/celeb/story_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditStory extends StatefulWidget {
  int? storyId;
  String? description;

  EditStory({
    Key? key,
    this.description,
    this.storyId,
  }) : super(key: key);

  @override
  _EditCourseState createState() => _EditCourseState();
}

class _EditCourseState extends State<EditStory> {
  var storyController = Get.put(StoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('تعديل عنوان المنشور',
            style: TextStyle(
                color: accentColor,
                fontFamily: 'Janna LT Regular',
                fontSize: 14.sp,
                fontWeight: FontWeight.bold)),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: accentColor,
            )),
        backgroundColor: buttonTextColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "عنوان المنشور",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
              initialValue: widget.description,
              onChanged: (value) {
                widget.description = value;
              },
            ),
            Expanded(child: SizedBox()),
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: double.infinity,
              height: 50.h,
              // ignore: deprecated_member_use
              child: Obx((() {
                if (storyController.isEditPost.value) {
                  return const GlobalLoading();
                }
                return TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      print("widget.description${widget.description}");
                      storyController.editStory(
                          storyId: widget.storyId,
                          description: widget.description);
                    },
                    child: Text(
                      'حفظ',
                      style: TextStyle(
                          color: buttonTextColor,
                          fontFamily: 'Janna LT Regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),
                    ));
              })),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
