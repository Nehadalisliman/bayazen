import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_back_button.dart';

class CreateChapter extends StatefulWidget {
  final int libararyId;
  final String libName;
  final int programId;
  const CreateChapter({
    Key? key,
    required this.libararyId,
    required this.libName,
    required this.programId,
  }) : super(key: key);

  @override
  State<CreateChapter> createState() => _CreateChapterState();
}

class _CreateChapterState extends State<CreateChapter> {
  final TextEditingController chapterTitle = TextEditingController();
  final TextEditingController chapterDescription = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final celebController = Get.find<CelebController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'رفع فصل جديد',
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Janna LT Regular',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: CustomBackButton(),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اسم الفصل",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'أدخل اسم الفصل',
                  controller: chapterTitle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجي ادخال اسم الفصل';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  "وصف الفصل",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'أدخل وصف الفصل',
                  controller: chapterDescription,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجي ادخال وصف الفصل';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                GetBuilder<CelebController>(
                  builder: (controller) => celebController.isCreateChapterLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: customElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                celebController.createChapter(
                                  title: chapterTitle.text,
                                  description: chapterDescription.text,
                                  libraryID: widget.libararyId,
                                  libraryName: widget.libName,
                                  programID: widget.programId,
                                  context: context,
                                );
                              }
                            },
                            text: 'حفظ الفصل',
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
