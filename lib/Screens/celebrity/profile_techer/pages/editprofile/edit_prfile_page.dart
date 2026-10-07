import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_back_button.dart';

class EditProfilePage extends StatefulWidget {
  final CelebController? getProfile;
  const EditProfilePage({Key? key, this.getProfile}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final CelebController celebController;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    celebController = widget.getProfile ?? (Get.isRegistered<CelebController>() ? Get.find<CelebController>() : Get.put(CelebController()));
    nameController.text = celebController.celebrityResponseModel.name ?? '';
    specController.text = celebController.celebrityResponseModel.specialization ?? '';
    bioController.text = celebController.celebrityResponseModel.bio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "تعديل الصفحة الشخصية",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            fontFamily: 'Janna LT Regular',
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: CustomBackButton(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.blue.shade50,
                    backgroundImage: celebController.celebrityResponseModel.image != null &&
                            celebController.celebrityResponseModel.image!.isNotEmpty
                        ? NetworkImage(celebController.celebrityResponseModel.image!)
                        : const AssetImage('assets/biz.png') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "الاسم الكامل",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna LT Regular',
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: nameController,
              hintText: 'أدخل الاسم الكامل',
            ),
            SizedBox(height: 16.h),
            Text(
              "التخصص / المسمى الوظيفي",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna LT Regular',
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: specController,
              hintText: 'أدخل التخصص (مثال: خبير البرمجة وتطوير الويب)',
            ),
            SizedBox(height: 16.h),
            Text(
              "نبذة عن المعلم",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna LT Regular',
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: bioController,
              maxLines: 4,
              hintText: 'اكتب نبذة مختصرة عن خبرتك ومجال تدريسك...',
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: customElevatedButton(
                onPressed: () {
                  celebController.celebrityResponseModel.name = nameController.text;
                  celebController.celebrityResponseModel.specialization = specController.text;
                  celebController.celebrityResponseModel.bio = bioController.text;
                  celebController.update();
                  Get.snackbar(
                    "نجاح",
                    "تم تحديث الملف الشخصي بنجاح",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    icon: const Icon(Icons.check, color: Colors.white),
                  );
                  Get.back();
                },
                text: 'حفظ التعديلات',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
