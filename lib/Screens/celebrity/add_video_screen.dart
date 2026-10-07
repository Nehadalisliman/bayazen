import 'dart:developer';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Controllers/celeb/upload_video_controller.dart';
import 'package:e_learning/Models/celebrity/chapter_model.dart';
import 'package:e_learning/Models/celebrity/libraries_model.dart';
import 'package:e_learning/Screens/celebrity/store/video_story.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Widgets/custom_elevated_button.dart';
import 'package:e_learning/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../Models/libraray_model.dart';
import '../../Models/video_library.dart';
import '../../Widgets/custom_text_field.dart';
import '../../Widgets/flushbar_helper.dart';
import '../../Widgets/custom_back_button.dart';

class AddVideoScreen extends StatefulWidget {
  final List<Chapter> chapters;
  final List<LibraryResponse>? libraries;

  final int programId;
  AddVideoScreen({
    Key? key,
    this.chapters = const [],
    this.programId = 1,
    this.libraries,
  }) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  File? _video;

  VideoPlayerController? _videoPlayerController;

  // final TeacherController tcontroller = Get.put(TeacherController());

  static final dropdownchaptersController = TextEditingController();

  static final dropdownlibrariesController = TextEditingController();

  // todo عنوان الفيديو
  final titleController = TextEditingController();

  // todo الوصف
  final descriptionController = TextEditingController();

  // todo عنوان المكتبه
  final librariesController = TextEditingController();

  // todo عنوان الشابتر
  final chaptersController = TextEditingController();

  final picker = ImagePicker();
  late CelebController uploadController;

  Future getLibrary() async {
    uploadController.isChapterLoading.value = false;
    // return await uploadController.getLibraryVideo(widget.programId);
  }

  @override
  void initState() {
    super.initState();
    uploadController = Get.put(CelebController());
    getLibrary();
  }

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  bool hasError = false;
  String errorMessage = "";

  @override
  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }
    super.dispose();
  }

  static final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // print(widget.libraries?[0].libraries?.length);
    log("rebudVideo ALl");
    return Scaffold(
        key: _scaffoldKey,

        // resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 45.h,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CustomBackButton(),
          ),
          title: customText(
              text: 'رفع فيديو',
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          //   physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                StatefulBuilder(builder: (BuildContext context, setTState) {
                  if (_video == null) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 10.h,
                        left: 10.w,
                        right: 10.w,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300,
                        ),
                        height: 150.h,
                        child: Center(
                          child: IconButton(
                              color: Colors.blueAccent,
                              onPressed: () async {
                                final video = (await picker.pickVideo(
                                    source: ImageSource.gallery))!;
                                _video = File(video.path);
                                _videoPlayerController =
                                    VideoPlayerController.file(_video!)
                                      ..initialize().then((_) {
                                        setState(() {});
                                        // _videoPlayerController.play();
                                      });
                              },
                              icon: Icon(Icons.cloud_upload_outlined)),
                        ),
                      ),
                    );
                  }
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: VideoStory(
                      videoUrl: _video!.path,
                    ),
                  );
                }),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      customLibrariesDropDown(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      customChaptersDropDown(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        controller: titleController,
                        hintText: 'عنوان الفيديو',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "برجاء ادخال عنوان فيديو";
                          }
                          if (value.length < 5) {
                            return "عنوان الفيديو  يجب ان يكون اكثر من 5 حروف";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        controller: descriptionController,
                        hintText: 'الوصف',
                        maxLines: 5,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "برجاء ادخال وصف فيديو";
                          }
                          if (value.length > 5000) {
                            return "الوصف لا يزيد عن 5000 حرف";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 180.h,
                      ),
                      Obx(() {
                        if (uploadController.isVideoUploading.value) {
                          return Center(
                              child: Container(
                            height: 150.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade300,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await uploadController.cancelUpload();
                                    },
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                      size: 30.sp,
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "جاري رفع الفيديو",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      uploadController.uploadString.value,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 25.sp,
                                    ),
                                    GlobalLoading()
                                  ],
                                ),
                              ],
                            ),
                          ));
                        }

                        return customElevatedButton(
                            text: 'رفع',
                            onPressed: () async {
                              log("titleController.text${titleController.text}");
                              log("descriptionController.text${descriptionController.text}");
                              log("dropdownlibrariesController.text${dropdownlibrariesController.text}");
                              log("chaptersController.text${dropdownchaptersController.text}");
                              log(" programId${widget.programId}");
                              if (_video == null) {
                                FlashHelper().errorBar(
                                    duration: Duration(seconds: 4),
                                    message: "برجاء رفع محتوي");
                                return;
                              }
                              if (_video != null) {
                                log("Video");
                                log("  _video.path${_video!.path}");
                                bool mp4 = _video!.path.contains("MP4") ||
                                    _video!.path.contains("mp4");
                                if (!mp4) {
                                  FlashHelper().errorBar(
                                      duration: Duration(seconds: 4),
                                      message: "يجب ان يكون الفيديو بصيغة mp4");

                                  return;
                                } else {
                                  int sizeInBytes = _video!.lengthSync();
                                  double sizeInMb = sizeInBytes / (1024 * 1024);
                                  if (sizeInMb > 100) {
                                    FlashHelper().errorBar(
                                        duration: Duration(seconds: 4),
                                        message:
                                            "يجب ان يكون حجم الفيديو اقل من 100 ميجا");
                                    return;
                                  }
                                }
                              }
                              if (_formKey.currentState!.validate()) {
                                log("valid");
                                // print(selectedValue!.title);
                                await uploadController.uploadVideo(
                                  programId: 2,
                                  chapter: selectedValue!.title ?? '',
                                  library_title: selectedValue!.title ?? '',
                                  description: descriptionController.text,
                                  title: titleController.text,
                                  context: context,

                                  // description: descriptionController.text,
                                  videoPath: _video!.path,
                                  // context: context,
                                );
                                setState(() {
                                  _video = null;
                                  titleController.clear();
                                  descriptionController.clear();
                                  dropdownlibrariesController.clear();
                                  dropdownchaptersController.clear();
                                });
                              }
                            });
                      }),
                      SizedBox(
                        height: 15.sp,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  LibraryModel2? selectedValue;
  List<LibraryModel2> get libList {
    List<LibraryModel2> flattenedList = [];
    if (widget.libraries != null) {
      for (var innerList in widget.libraries!.map((e) => e.libraries).toList()) {
        if (innerList != null) {
          flattenedList.addAll(innerList);
        }
      }
    }
    if (flattenedList.isEmpty) {
      flattenedList.add(LibraryModel2(id: 1, title: 'المكتبة الافتراضية العامة'));
    }
    return flattenedList;
  }

  Widget customLibrariesDropDown(BuildContext context) {
    return DropdownButtonFormField<LibraryModel2?>(
      value: selectedValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: outlineInputBorder(),
        errorBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
      ),
      hint: Text('يرجي اختيار المكتبة'),
      onChanged: (LibraryModel2? newValue) {
        setState(() {
          selectedValue = newValue;
          print('drop ${selectedValue!.title}');
        });
      },
      items: libList
          .map((lib) => DropdownMenuItem(
                child: Text("${lib.title}"),
                value: lib, // Set the value to the title of the library
              ))
          .toList(),
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5),
    );
  }

  Widget customChaptersDropDown(BuildContext context) {
    return Obx(
      () {
        if (uploadController.isChapterLoading.value == true) {
          return GlobalLoading();
        }

        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                )
              ]),
          child: Stack(
            children: [
              Positioned(
                // right: 5,
                top: 5,
                left: 5,
                bottom: 5,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        isExpanded: true,
                        items: List.generate(
                            uploadController.chapters.length,
                            (index) => DropdownMenuItem<String>(
                                value: uploadController.chapters[index].title,
                                child: Text(
                                    uploadController.chapters[index].title!))),
                        onChanged: (value) =>
                            dropdownchaptersController.text = value!),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'عنوان الفصل / اختر العنوان',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "برجاء ادخال عنوان الفصل";
                      }

                      return null;
                    },
                    controller: dropdownchaptersController,
                  )),
                  const SizedBox.square(dimension: 48.0)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
// return FutureBuilder(
//     future: getLibrary(),
//     builder: (ctx, snapshot) {
//       // Checking if future is resolved or not
//       if (snapshot.connectionState == ConnectionState.done) {
//         print("Done");
//         print(snapshot.data.toString());
//         // If we got an error
//         if (snapshot.hasError) {
//           print("ERROR");
//           return Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                   )
//                 ]),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: 'عنوان المكتبه / اختر العنوان',
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(25)),
//                 errorBorder: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(25)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(25)),
//               ),
//               validator: (String? value) {
//                 return "  ";
//               },
//             ),
//           );

//           // if we got our data
//         } else if (snapshot.hasData) {
//           // Extracting data from snapshot object
//           if (snapshot.data is String) {
//             return Center(
//               child: Text(
//                 '${snapshot.data}',
//                 style: TextStyle(fontSize: 18.sp, color: Colors.red),
//               ),
//             );
//           }
//           print("data");
//           final data = snapshot.data as bool?;
//           print("data");
//           return Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                   )
//                 ]),
//             child: Stack(
//               children: [
//                 Positioned(
//                   // right: 5,
//                   top: 5,
//                   left: 5,
//                   bottom: 5,
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                           isExpanded: true,
//                           items: List.generate(
//                               uploadController.libraries.length,
//                               (index) => DropdownMenuItem<String>(
//                                   value: uploadController
//                                       .libraries[index].title,
//                                   child: Text(uploadController
//                                       .libraries[index].title!))),
//                           onChanged: (value) async {
//                             await uploadController.getChaptersVideo(
//                                 libraryName: value,
//                                 programID: widget.programId);
//                             dropdownlibrariesController.text = value!;
//                           }),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                         child: TextFormField(
//                       decoration: InputDecoration(
//                         hintText: 'عنوان المكتبه / اختر العنوان',
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(25)),
//                         errorBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(25)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(25)),
//                       ),
//                       controller: dropdownlibrariesController,
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return "برجاء ادخال عنوان المكتبه";
//                         }
//                         return null;
//                       },
//                     )),
//                     const SizedBox.square(dimension: 48.0)
//                   ],
//                 ),
//               ],
//             ),
//           );
//         }
//       }

//       // Displaying LoadingSpinner to indicate waiting state
//       return GlobalLoading();
//     });

class MyApp2 extends StatelessWidget {
  final List<List<String>> nestedList = [
    ['Option 1-1', 'Option 1-2', 'Option 1-3'],
    ['Option 2-1', 'Option 2-2'],
    ['Option 3-1', 'Option 3-2', 'Option 3-3', 'Option 3-4'],
    ['Option 4-1'],
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dropdown Example'),
        ),
        body: Center(
          child: MyDropdown(items: flattenList(nestedList)),
        ),
      ),
    );
  }

  List<String> flattenList(List<List<String>> nestedList) {
    List<String> flattenedList = [];
    for (var innerList in nestedList) {
      flattenedList.addAll(innerList);
    }
    return flattenedList;
  }
}

class MyDropdown extends StatefulWidget {
  final List<String> items;

  MyDropdown({required this.items});

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue.isEmpty ? null : selectedValue,
        hint: Text('Select an option'),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          // suffixIcon: Icon(Icons.arrow_drop_down),
        ),
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
