import 'dart:io';

import 'package:e_learning/Controllers/course_ware_controller.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class CreateCourse extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController course_title = TextEditingController();
  final FocusNode _titleFocus = FocusNode();

  File? image;
  final picker = ImagePicker();
  selectFile() async {}

  late PlatformFile file;
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = result.files.first;
    } else {
      // User canceled the picker
    }
  }

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
              if (image != null)
                Image.file(image!, fit: BoxFit.cover)
              else
                Container(
                    margin: const EdgeInsets.only(top: 20, left: 30),
                    width: 300,
                    height: 100,
                    color: Colors.grey.shade200,
                    child: InkWell(
                        onTap: () {
                          _pickFile();
                        },
                        child: const Icon(
                          Icons.cloud_upload_outlined,
                          color: primaryColor,
                        ))),
              CustomTextField(
                controller: course_title,
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
                hintText: 'عنوان الكورس',
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 30),
                // ignore: deprecated_member_use
                child: TextButton(
                    onPressed: () {
                      _formKey.currentState?.save();
                      //  FlashHelper().infoBar(message: "MB ${double.parse("${image.lengthSync()/1048576}").toStringAsFixed(2)}   حجم الملف ");
                      CourseWareController().uploadCourse(
                          file: file,
                          title: course_title.text,
                          context: context);
                      course_title.clear();
                    },
                    child: const Text(
                      ' رفع الكورس',
                      style: TextStyle(
                          color: buttonTextColor,
                          fontFamily: 'Janna LT Regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
