// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/core/helpers/size_config.dart';

class Upload extends StatefulWidget {
  final String nameChapter;
  final String nameLibarary;
  final int programId;
  final int chapterId;

  const Upload({
    Key? key,
    required this.nameChapter,
    required this.nameLibarary,
    required this.programId,
    required this.chapterId,
  }) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File? _video;
  late VideoPlayerController _videoPlayerController;
  final picker = ImagePicker();
  final celebController = Get.find<CelebController>();

  _pickVideo() async {
    final video = (await picker.pickVideo(source: ImageSource.gallery))!;
    _video = File(video.path);
    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {
          debugPrint(
              "========" + _videoPlayerController.value.duration.toString());
        });
        // _videoPlayerController.();
      });
  }

  SizeConfig sizeConfig = SizeConfig();

  bool? isSelected;

  final FocusNode _titleFocus = FocusNode();

  final FocusNode _descriptionFocus = FocusNode();

  final RxBool isVisible = RxBool(false);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController title = TextEditingController();

  final TextEditingController description = TextEditingController();
  // final TeacherController controller=Get.put(TeacherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('انشاء',
            style: TextStyle(
                color: accentColor,
                fontFamily: 'Janna LT Regular',
                fontSize: 18,
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
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              if (_video != null)
                _videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: 16 / 13,
                        child: VideoPlayer(_videoPlayerController),
                      )
                    : Container()
              else
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 300,
                    height: 100,
                    color: Colors.grey.shade200,
                    child: InkWell(
                        onTap: () {
                          _pickVideo();
                        },
                        child: const Icon(
                          Icons.cloud_upload_outlined,
                          color: primaryColor,
                        ))),
              SizedBox(height: 10),
              CustomTextField(
                controller: title,
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return;
                  }
                  return null;
                },
                onSubmitted: (tern) => () {
                  _titleFocus.unfocus();
                  FocusScope.of(context).unfocus();
                  // Hide KeyBord
                },
                hintText: 'عنوان الغيديو',
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: description,
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return;
                  }
                  return null;
                },
                onSubmitted: (tern) => () {
                  _descriptionFocus.unfocus();
                  FocusScope.of(context).unfocus();
                },
                hintText: 'وصف الفيديو',
              ),
              Obx(
                () => celebController.isVideoUploading.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: TextButton(
                            onPressed: () {
                              _formKey.currentState?.save();

                              print(_video?.path);
                              FlashHelper().infoBar(
                                  message:
                                      "MB ${double.parse("${_video!.lengthSync() / 1048576}").toStringAsFixed(2)}   حجم الملف ");
                              celebController.uploadVideo(
                                  title: title.text,
                                  description: description.text,
                                  videoPath: _video?.path ?? '',
                                  library_title: widget.nameLibarary,
                                  chapter: widget.nameChapter,
                                  programId: widget.programId,
                                  context: context,
                                  chapterID: widget.chapterId);
                              // title.clear();
                              // description.clear();
                              // Flushbar(message: 'Uploading  Success',duration: Duration(seconds: 10),).show(context);
                            },
                            child: const Text(
                              ' حفظ',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'Janna LT Regular',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
     // Container(
              //   height: 200,
              //   child: VideoItems(
              //     videoPlayerController:
              //     VideoPlayerController
              //         .file(file?.path??File('${file}'))
              //     ,
              //     looping: true,
              //     autoplay: false, width:sizeConfig.screenWidth, fit: BoxFit.cover,
              //   ),
              // ),