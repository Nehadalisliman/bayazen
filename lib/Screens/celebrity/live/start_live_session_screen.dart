import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/Widgets/custom_back_button.dart';
import 'package:e_learning/core/Services/firebase_service.dart';

class StartLiveSessionScreen extends StatefulWidget {
  const StartLiveSessionScreen({Key? key}) : super(key: key);

  @override
  State<StartLiveSessionScreen> createState() => _StartLiveSessionScreenState();
}

class _StartLiveSessionScreenState extends State<StartLiveSessionScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isCreating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'بدء بث مباشر جديد',
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Janna LT Regular',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: const CustomBackButton(),
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.fiber_manual_record, color: Colors.red, size: 20.sp),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "بث مباشر تفاعلي مع الطلاب",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Janna LT Regular',
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  "عنوان البث",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'أدخل عنوان المحاضرة أو البث',
                  controller: titleController,
                  validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال عنوان البث' : null,
                ),
                SizedBox(height: 16.h),
                Text(
                  "وصف البث",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'اكتب تفاصيل المحاضرة المباشرة...',
                  controller: descController,
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                Text(
                  "رابط البث (YouTube / Zoom / Meet / WebRTC)",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: 'https://youtube.com/...',
                  controller: urlController,
                  validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال رابط البث' : null,
                ),
                SizedBox(height: 24.h),
                isCreating
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: customElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => isCreating = true);
                              try {
                                final firebaseService = FirebaseService();
                                await firebaseService.addDocument('live_sessions', {
                                  'title': titleController.text,
                                  'description': descController.text,
                                  'url': urlController.text,
                                  'isLive': true,
                                  'instructor': 'د. أحمد الشريف',
                                });
                                Get.snackbar(
                                  "نجاح",
                                  "تم بدء البث المباشر بنجاح وإرساله للطلاب",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  icon: const Icon(Icons.check, color: Colors.white),
                                );
                                Get.back();
                              } catch (e) {
                                Get.snackbar("خطأ", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
                              } finally {
                                setState(() => isCreating = false);
                              }
                            }
                          },
                          text: 'بدء البث المباشر الآن',
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
