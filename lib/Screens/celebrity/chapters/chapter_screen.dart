import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/constants.dart';
import 'create_chapter.dart';
import 'package:e_learning/Screens/old_work/video_library.dart';
import 'package:e_learning/Widgets/custom_back_button.dart';

class ChapterScreen extends StatefulWidget {
  final int programId;
  final String libName;
  final int libID;
  final CelebController? celebController;
  const ChapterScreen({
    Key? key,
    this.programId = 1,
    this.libName = 'افتراضي',
    this.libID = 1,
    this.celebController,
  }) : super(key: key);

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late final CelebController celebController;
  @override
  void initState() {
    super.initState();
    celebController = widget.celebController ?? (Get.isRegistered<CelebController>() ? Get.find<CelebController>() : Get.put(CelebController()));
    try {
      celebController.getChapters(
        programID: widget.programId,
        libraryName: widget.libName,
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: const StadiumBorder(),
        onPressed: () {
          Get.to(() => CreateChapter(
                libararyId: widget.libID,
                programId: widget.programId,
                libName: widget.libName,
              ));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'جميع الفصول',
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
      body: Obx(
        () => celebController.isChapterLoading.value
            ? const Center(child: CircularProgressIndicator())
            : celebController.chapters.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Text(
                        'لا يوجد فصول فى هذه المكتبة',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Janna LT Regular',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(16.w),
                    itemCount: celebController.chapters.length,
                    itemBuilder: (context, index) {
                      final itemChapter = celebController.chapters[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(14.w),
                            leading: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(Icons.bookmark_border_rounded, color: primaryColor, size: 22.sp),
                            ),
                            title: Text(
                              itemChapter.title ?? 'بدون عنوان',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Janna LT Regular',
                                color: Colors.black87,
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey.shade400),
                            onTap: () {
                              Get.to(() => VideoLibrary(
                                    nameChapter: itemChapter.title ?? '',
                                    nameLibarary: widget.libName,
                                    programId: widget.programId,
                                    chapterId: itemChapter.id ?? 1,
                                  ));
                            },
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
