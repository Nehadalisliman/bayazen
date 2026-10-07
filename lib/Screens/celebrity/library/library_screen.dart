// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_learning/Screens/celebrity/chapters/chapter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Models/video_library.dart';
import 'package:e_learning/Screens/old_work/upload.dart';

import '/constants.dart';
import 'create_library_screen.dart';
import 'package:e_learning/Widgets/custom_back_button.dart';

class LibraryScreen extends StatefulWidget {
  final int programId;
  final CelebController? celebController;
  const LibraryScreen({
    Key? key,
    this.programId = 1,
    this.celebController,
  }) : super(key: key);
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late final CelebController celebController;
  @override
  void initState() {
    super.initState();
    celebController = widget.celebController ?? (Get.isRegistered<CelebController>() ? Get.find<CelebController>() : Get.put(CelebController()));
    try {
      celebController.getLibraries(programId: widget.programId);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: StadiumBorder(),
          onPressed: () {
            Get.to(() => CreateLibrary(
                  programdId: widget.programId,
                ));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('جميع المكاتب',
              style: TextStyle(
                  color: accentColor,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CustomBackButton(),
          ),
          backgroundColor: buttonTextColor,
        ),
        body: GetBuilder<CelebController>(
          builder: (controller) => controller.isLibararyLoading
              ? Center(child: CircularProgressIndicator())
              : controller.libraryListOBX.isEmpty
                  ? Center(
                      child: Text(
                      'لا يوجد مكاتب فى هذا البرنامج',
                      style: TextStyle(
                        fontFamily: 'Janna LT Regular',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
                  : ListView.builder(
                      itemCount: controller.libraryListOBX.length,
                      itemBuilder: (context, index) {
                        final itemLib = controller.libraryListOBX[index];
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () async {
                                  print(itemLib.id);
                                  Get.to(ChapterScreen(
                                    libID: itemLib.id!,
                                    libName: itemLib.title!,
                                    programId: widget.programId,
                                    celebController: celebController,
                                  ));
                                },
                                child: Card(
                                  color: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      height: 60.h,
                                      width: double.infinity,
                                      child: Center(
                                          child: Text(
                                        '${itemLib.title}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ))),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
        ));
  }
}
