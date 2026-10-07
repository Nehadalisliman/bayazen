import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/Widgets/custom_back_button.dart';
import 'package:e_learning/core/Services/firebase_service.dart';

class UploadAssignmentScreen extends StatefulWidget {
  const UploadAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<UploadAssignmentScreen> createState() => _UploadAssignmentScreenState();
}

class _UploadAssignmentScreenState extends State<UploadAssignmentScreen> {
  int selectedTab = 0; // 0: مذكرة / واجب, 1: امتحان تفاعلي
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController scoreController = TextEditingController(text: '100');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? selectedFile;
  String? fileName;
  bool isUploading = false;

  // Exam Questions list
  final List<Map<String, dynamic>> examQuestions = [];
  final TextEditingController qController = TextEditingController();
  final TextEditingController opt1Controller = TextEditingController();
  final TextEditingController opt2Controller = TextEditingController();
  final TextEditingController opt3Controller = TextEditingController();
  int correctOptionIndex = 0;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'ppt'],
    );
    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        fileName = result.files.single.name;
      });
    }
  }

  void addQuestion() {
    if (qController.text.isNotEmpty && opt1Controller.text.isNotEmpty && opt2Controller.text.isNotEmpty) {
      setState(() {
        examQuestions.add({
          'question': qController.text,
          'options': [opt1Controller.text, opt2Controller.text, opt3Controller.text],
          'correct': correctOptionIndex,
        });
        qController.clear();
        opt1Controller.clear();
        opt2Controller.clear();
        opt3Controller.clear();
        correctOptionIndex = 0;
      });
      Get.snackbar("تم", "تمت إضافة السؤال بنجاح", backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("تنبيه", "يرجى إدخال السؤال وخيارين على الأقل", backgroundColor: Colors.orange, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'إدارة المذكرات والامتحانات الذكية',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Smart Tab Selector
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: selectedTab == 0 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: selectedTab == 0
                              ? [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))]
                              : [],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "رفع مذكرة / واجب",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna LT Regular',
                            color: selectedTab == 0 ? primaryColor : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 1),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: selectedTab == 1 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: selectedTab == 1
                              ? [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))]
                              : [],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "إنشاء امتحان تفاعلي",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna LT Regular',
                            color: selectedTab == 1 ? primaryColor : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            Container(
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
                      selectedTab == 0 ? "عنوان المذكرة أو الواجب" : "عنوان الاختبار التفاعلي",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Janna LT Regular',
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: selectedTab == 0 ? 'أدخل عنوان المذكرة...' : 'أدخل عنوان الامتحان النهائي...',
                      controller: titleController,
                      validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال العنوان' : null,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "الدرجة الكلية",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Janna LT Regular',
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: '100',
                      controller: scoreController,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "الوصف والتعليمات",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Janna LT Regular',
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: 'اكتب الشروط والتعليمات للطلاب...',
                      controller: descController,
                      maxLines: 3,
                    ),
                    SizedBox(height: 20.h),

                    if (selectedTab == 0) ...[
                      Text(
                        "ملف المذكرة / الواجب (PDF)",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Janna LT Regular',
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: pickFile,
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade200, width: 1),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.upload_file_rounded, color: primaryColor, size: 24.sp),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  fileName ?? "اختر ملف PDF أو مستند...",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Janna LT Regular',
                                    color: fileName != null ? Colors.black87 : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      Divider(height: 30.h),
                      Text(
                        "إضافة أسئلة الامتحان الذكي",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Janna LT Regular',
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(hintText: 'نص السؤال...', controller: qController),
                      SizedBox(height: 10.h),
                      CustomTextField(hintText: 'الخيار الأول (أ)', controller: opt1Controller),
                      SizedBox(height: 10.h),
                      CustomTextField(hintText: 'الخيار الثاني (ب)', controller: opt2Controller),
                      SizedBox(height: 10.h),
                      CustomTextField(hintText: 'الخيار الثالث (ج)', controller: opt3Controller),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Text("الإجابة الصحيحة:", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                          SizedBox(width: 12.w),
                          DropdownButton<int>(
                            value: correctOptionIndex,
                            items: const [
                              DropdownMenuItem(value: 0, child: Text("الخيار الأول")),
                              DropdownMenuItem(value: 1, child: Text("الخيار الثاني")),
                              DropdownMenuItem(value: 2, child: Text("الخيار الثالث")),
                            ],
                            onChanged: (val) => setState(() => correctOptionIndex = val ?? 0),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      OutlinedButton.icon(
                        onPressed: addQuestion,
                        icon: const Icon(Icons.add),
                        label: const Text("إضافة السؤال للاختبار"),
                      ),
                      SizedBox(height: 10.h),
                      if (examQuestions.isNotEmpty)
                        Text(
                          "تمت إضافة ${examQuestions.length} سؤال حتى الآن.",
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12.sp),
                        ),
                    ],

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
                                    await firebaseService.addDocument('assignments', {
                                      'title': titleController.text,
                                      'description': descController.text,
                                      'type': selectedTab == 0 ? 'assignment' : 'exam',
                                      'score': scoreController.text,
                                      'fileName': fileName ?? 'مذكرة تعليمية',
                                      'questions': examQuestions,
                                      'instructor': 'د. أحمد الشريف',
                                      'createdAt': DateTime.now().toIso8601String(),
                                    });
                                    Get.snackbar(
                                      "نجاح",
                                      selectedTab == 0 ? "تم نشر المذكرة بنجاح" : "تم نشر الامتحان الذكي وتفعيل استقبال إجابات الطلاب",
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
                              text: selectedTab == 0 ? 'نشر المذكرة أو الواجب' : 'إطلاق الامتحان التفاعلي للطلاب',
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
