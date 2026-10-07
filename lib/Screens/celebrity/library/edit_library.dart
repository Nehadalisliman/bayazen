import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Widgets/custom_text_field.dart';

// ignore: must_be_immutable
class EditLibrary extends StatefulWidget {
  int? libraryId;
  String? title;
  String? description;

  EditLibrary({
    Key? key,
    this.title,
    this.description,
    this.libraryId,
  }) : super(key: key);

  @override
  _EditLibraryState createState() => _EditLibraryState();
}

class _EditLibraryState extends State<EditLibrary> {
  var teacherController = Get.put(CelebController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('تعديل عنوان المكتبه',
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
              "اسم المكتبه",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextField(
              initialValue: widget.title,
              onChanged: (value) {
                widget.title = value;
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "الوصف",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
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
                if (teacherController.isEditLibraryLoading.value) {
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
                      teacherController.editLibrary(
                          description: widget.description,
                          title: widget.title,
                          libraryId: widget.libraryId);
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
