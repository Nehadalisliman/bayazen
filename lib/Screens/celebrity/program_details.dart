// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:e_learning/Models/celebrity/chapter_model.dart';
import 'package:e_learning/Screens/celebrity/add_video_screen.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_text.dart';

import '../../Controllers/celeb/celeb_controller.dart';
import '../../Models/libraray_model.dart';
import '../../Models/video_library.dart';
import 'add_educational_curricula.dart';
import 'library/library_screen.dart';

class ProgramDetailsScreen extends StatefulWidget {
  const ProgramDetailsScreen({
    Key? key,
    required this.title,
    required this.programId,
    this.chapters,
    required this.libraries,
    required this.celebController,
  }) : super(key: key);
  final String title;
  final int programId;
  final RxList<Chapter>? chapters;
  final List<LibraryResponse> libraries;
  final CelebController celebController;

  @override
  State<ProgramDetailsScreen> createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: customText(
            text: widget.title,
            color: Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              customText(
                  text: 'شارك خبراتك مع ${widget.title}',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  Icon(Icons.video_collection_outlined),
                  SizedBox(width: 5.w),
                  customText(
                      text: 'رفع مكتبة',
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                  const Spacer(),
                  customElevatedButton(
                      text: 'رفع',
                      fontSize: 12,
                      onPressed: () {
                        Get.to(
                          () => LibraryScreen(
                            celebController: widget.celebController,
                            programId: widget.programId,
                          ),
                        );
                        // Get.to(AddVideoScreen(
                        //   programId: widget.programId,
                        //   chapters: [],
                        //   libraries: widget.libraries,
                        // ));
                      },
                      width: 70.w,
                      height: 22,
                      radius: 8),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Icon(Icons.filter_frames),
                  SizedBox(
                    width: 5.w,
                  ),
                  customText(
                      text: 'رفع المناهج التعليميه',
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                  const Spacer(),
                  customElevatedButton(
                      text: 'رفع',
                      fontSize: 12,
                      onPressed: () {
                        Get.to(AddEducationalCurricula(
                          programId: widget.programId,
                        ));
                      },
                      width: 70.w,
                      height: 22,
                      radius: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
