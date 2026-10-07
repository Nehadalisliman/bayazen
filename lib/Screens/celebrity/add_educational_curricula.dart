import 'dart:developer';
import 'dart:io';

import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_text.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Widgets/flushbar_helper.dart';
import '../../Widgets/custom_back_button.dart';
import '../../core/Services/firebase_service.dart';

enum MediaType { image, video }

class AddEducationalCurricula extends StatefulWidget {
  final int? programId;
  const AddEducationalCurricula({Key? key, this.programId}) : super(key: key);

  @override
  State<AddEducationalCurricula> createState() =>
      _AddEducationalCurriculaState();
}

class _AddEducationalCurriculaState extends State<AddEducationalCurricula> {
  File? mediaFile;
  String mediaType = 'image';
  final picker = ImagePicker();
  bool isUploading = false;

  pickMedia(MediaType type) async {
    if (type == MediaType.image) {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          mediaFile = File(picked.path);
          mediaType = 'image';
        });
      }
    } else {
      final picked = await picker.pickVideo(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          mediaFile = File(picked.path);
          mediaType = 'video';
        });
      }
    }
  }

  final categoryController = TextEditingController();
  final titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'رفع صورة أو فيديو للدورة',
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
                  "اختر نوع الوسائط (صورة أو فيديو)",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mediaType == 'image' ? primaryColor : Colors.grey.shade100,
                          foregroundColor: mediaType == 'image' ? Colors.white : Colors.black87,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        onPressed: () => pickMedia(MediaType.image),
                        icon: const Icon(Icons.image_rounded, size: 18),
                        label: Text("صورة الدورة", style: TextStyle(fontFamily: 'Janna LT Regular', fontSize: 12.sp)),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mediaType == 'video' ? primaryColor : Colors.grey.shade100,
                          foregroundColor: mediaType == 'video' ? Colors.white : Colors.black87,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        onPressed: () => pickMedia(MediaType.video),
                        icon: const Icon(Icons.video_call_rounded, size: 18),
                        label: Text("فيديو الدورة", style: TextStyle(fontFamily: 'Janna LT Regular', fontSize: 12.sp)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: mediaFile == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined, size: 36.sp, color: primaryColor),
                              SizedBox(height: 6.h),
                              Text(
                                "لم يتم اختيار أي ملف بعد",
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500, fontFamily: 'Janna LT Regular'),
                              ),
                            ],
                          ),
                        )
                      : mediaType == 'image'
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.file(mediaFile!, fit: BoxFit.cover, width: double.infinity),
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.videocam_rounded, color: primaryColor, size: 30.sp),
                                  SizedBox(width: 8.w),
                                  Text("تم اختيار الفيديو بنجاح", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, fontFamily: 'Janna LT Regular')),
                                ],
                              ),
                            ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "عنوان الفئة / القسم",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'مثال: برمجة وتطوير',
                  controller: categoryController,
                  validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال فئة الدورة' : null,
                ),
                SizedBox(height: 16.h),
                Text(
                  "عنوان الدورة التدريبية",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'مثال: تطوير تطبيقات الموبايل بـ Flutter',
                  controller: titleController,
                  validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال عنوان الدورة' : null,
                ),
                SizedBox(height: 24.h),
                isUploading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: customElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => isUploading = true);
                              try {
                                final firebaseService = FirebaseService();
                                await firebaseService.addDocument('courses', {
                                  'name': titleController.text,
                                  'title': titleController.text,
                                  'category': categoryController.text,
                                  'mediaType': mediaType,
                                  'description': "دورة تعليمية احترافية في ${categoryController.text}",
                                  'image': mediaFile != null && mediaType == 'image' ? mediaFile!.path : 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=500',
                                  'video': mediaFile != null && mediaType == 'video' ? mediaFile!.path : '',
                                  'instructor': 'د. أحمد الشريف',
                                  'createdAt': DateTime.now().toIso8601String(),
                                });
                                Get.snackbar(
                                  "نجاح",
                                  "تم نشر الدورة ووسائطها بنجاح",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  icon: const Icon(Icons.check, color: Colors.white),
                                );
                                Get.back();
                              } catch (e) {
                                Get.snackbar("خطأ", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
                              } finally {
                                setState(() => isUploading = false);
                              }
                            }
                          },
                          text: 'حفظ ونشر الدورة',
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
