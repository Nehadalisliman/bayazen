import 'dart:io';

import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../../constants.dart';

class UploadMagazine extends StatefulWidget {
  const UploadMagazine({Key? key}) : super(key: key);

  @override
  _UploadMagazineState createState() => _UploadMagazineState();
}

class _UploadMagazineState extends State<UploadMagazine> {
  bool? isSelected;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? image;
  final picker = ImagePicker();
  selectFile() async {
    // image = await FilePicker.getFile(
    //   type: FileType.custom,
    //   allowedExtensions: ['jpg', 'pdf', 'mp4'],
    //   //allowed extension to choose
    // );
    // FilePickerResult result =await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['jpg', 'pdf', 'mp4'],
    //   //allowed extension to choose
    // );
    // if(result != null) {
    //   PlatformFile file = result.files.first;
    //
    //   print(file.name);
    //   print(file.bytes);
    //   print(file.size);
    //   print(file.extension);
    //   print(file.path);
    // } else {
    //   // User canceled the picker
    // }
    // }
    // Future pickImageFromGallery(ImageSource source) async {
    //   File picker = await ImagePicker.pickImage(source: source);
    //   setState(() {
    //     image = picker;
    //   });
    // }
  }

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
              Container(
                margin: const EdgeInsets.only(top: 15, left: 30),
                // ignore: deprecated_member_use
                child: TextButton(
                    onPressed: () {
                      _formKey.currentState?.save();
                      CelebController().uploadMagazine(file: file);
                    },
                    child: const Text(
                      ' حفظ',
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
