import 'package:e_learning/core/global/globalloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_learning/Widgets/custom_back_button.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import '/constants.dart';

class CreateLibrary extends StatefulWidget {
  final int programdId;
  const CreateLibrary({
    Key? key,
    required this.programdId,
  }) : super(key: key);

  @override
  State<CreateLibrary> createState() => _CreateLibraryState();
}

class _CreateLibraryState extends State<CreateLibrary> {
  final TextEditingController category_title = TextEditingController();
  final TextEditingController category_description = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'رفع مكتبة جديدة',
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
                  "اسم المكتبة",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'أدخل اسم المكتبة',
                  controller: category_title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجي ادخال اسم المكتبة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  "وصف المكتبة",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'أدخل وصف المكتبة',
                  controller: category_description,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجي ادخال وصف المكتبة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                GetBuilder<CelebController>(
                  builder: (controller) => controller.isLibararyCreateLoading
                      ? const Center(child: GlobalLoading())
                      : SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: customElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                controller.createLibraray(
                                  context: context,
                                  title: category_title.text,
                                  description: category_description.text,
                                  programId: widget.programdId,
                                );
                              }
                            },
                            text: 'حفظ المكتبة',
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
