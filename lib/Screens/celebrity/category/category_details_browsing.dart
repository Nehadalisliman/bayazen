import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_learning/Controllers/browsing_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/helpers/directory_path.dart';
import 'package:path/path.dart' as Path;

class CategoryDetailsBrowsing extends StatefulWidget {
  final bool? isBrowsing;
  final int? courseId;
  final int? categoryId;
  final String courseLink;
  final String? courseTitle;
  final String? courseDescription;
  CategoryDetailsBrowsing(
      {Key? key,
      this.courseId,
      required this.courseLink,
      this.categoryId,
      this.courseTitle,
      this.courseDescription,
      this.isBrowsing})
      : super(key: key);

  @override
  State<CategoryDetailsBrowsing> createState() =>
      _CategoryDetailsBrowsingState();
}

class _CategoryDetailsBrowsingState extends State<CategoryDetailsBrowsing> {
  final browsingController = Get.put(BrowsingController());
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  File? pdfFile;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();
  String? name;
  String? courseUrl;

  @override
  void initState() {
    isDownload.value = false;
    download.value = 0;
    if (browsingController.celebrityResponseModel == null) {
      name = "";
    } else {
      name = browsingController.celebrityResponseModel!.name ?? '';
    }
    setState(() {
      fileName = Path.basename(widget.courseLink);
    });
    checkFileExit();
    getVideo();
    super.initState();
  }

  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      dowloading = true;
      progress = 0;
    });

    try {
      await Dio().download(widget.courseLink, filePath,
          onReceiveProgress: (count, total) {
        setState(() {
          progress = (count / total);
        });
      }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    pdfFile = File(filePath);
    bool fileExistCheck = await pdfFile!.exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openfile() {
    OpenFile.open(filePath);
    print("fff $filePath");
  }

  getVideo() async {
    // browsingController.getCelebCourseBrowsing(
    //     courseId: widget.courseId!, categoryId: widget.categoryId!);
    String link = widget.courseLink;
    print("Link $link");
    courseUrl = execDecode(link, 'course');
    print("courseUrl $courseUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الكورس',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          isDownload.value = false;
          download.value = 0;
          // browsingController.getCelebVideoBrowsing(chapterId: 20, celebId: 8);
          // String link = browsingController.videoBrwosing.link!;
          String link = widget.courseLink;
          print("Link $link");
          courseUrl = execDecode(link, 'course');
          print("courseUrl $courseUrl");

          return Future.value(true);
        },
        child: ListView(children: [
          Obx(() {
            if (browsingController.isCourseLoading.value) {
              return Column(
                children: [
                  SizedBox(height: 250.h),
                  GlobalLoading(),
                ],
              );
            }

            return SizedBox(
                height: 0.8.sh,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // courseUrl == "https://bayzin.com/uploads/courseware/"
                    //     ? SizedBox(
                    //         height: 200.h,
                    //         width: double.infinity,
                    //         child: Center(
                    //           child: Text('برجاء الاشتراك',
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                 color: Colors.red,
                    //                 fontSize: 25.sp,
                    //                 fontFamily: 'Cairo',
                    //                 fontWeight: FontWeight.bold,
                    //               )),
                    //         ),
                    //       )
                    //     :
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        height: 200.h,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                fileExists && dowloading == false
                                    ? openfile()
                                    : startDownload();
                              },
                              icon: fileExists && dowloading == false
                                  ? Icon(
                                      Icons.file_open_rounded,
                                      color: Colors.blue,
                                      size: 50.sp,
                                    )
                                  : Icon(
                                      Icons.download_outlined,
                                      color: Colors.blue,
                                      size: 50.sp,
                                    ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                                fileExists && dowloading == false
                                    ? 'اضغط على الايقونة لفتح الملف'
                                    : 'تحميل',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 10.sp,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 10.h),
                            dowloading
                                ? CircularProgressIndicator(
                                    value: progress,
                                    strokeWidth: 3,
                                    backgroundColor: Colors.grey,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.blue),
                                  )
                                : SizedBox.shrink(),
                            // Obx(() {
                            //   if (isDownload.value) {
                            //     return Text(
                            //       'جاري التحميل ${_progress.toString()} %',
                            //       style: TextStyleTween(
                            //         begin: TextStyle(
                            //           color: Colors.blue,
                            //           fontSize: 14.sp,
                            //           fontFamily: 'Cairo',
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //         end: TextStyle(
                            //           color: Colors.red,
                            //           fontSize: 14.sp,
                            //           fontFamily: 'Cairo',
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ).lerp(download.value),
                            //     );
                            //   }
                            //   return SizedBox();
                            // })

                            // Text(_progress),
                          ],
                          // width: 100.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.sp),
                      child: Text(widget.courseTitle!,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.sp),
                      child: Text(widget.courseDescription!,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    widget.isBrowsing!
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.sp),
                            child: ListTile(
                                title: Text(
                                  name ?? "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  browsingController
                                      .celebrityResponseModel!.specialization!,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13.sp,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: browsingController
                                            .celebrityResponseModel!.image !=
                                        ''
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            browsingController
                                                .celebrityResponseModel!
                                                .image!),
                                      )
                                    : SizedBox()),
                          )
                        : SizedBox(),
                    Expanded(child: SizedBox()),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ));
          })
        ]),
      ),
    );
  }

  RxDouble download = RxDouble(0);
  RxBool isDownload = RxBool(false);
  String _progress = "";
  dawnloadFile({required String link, String? name}) async {
    Dio dio = Dio();
    try {
      isDownload.value = true;
      download.value = 0;
      var dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/$name";
      await dio.download(link, filePath, onReceiveProgress: (rec, total) {
        log("Rec: $rec , Total: $total");
        log("download${download.value.toDouble().toInt()}");
        download.value = (rec.toDouble() / total.toDouble()) * 100;
      }).then((value) async {
        isDownload.value = false;
        OpenFile.open(filePath);
        // if (value.statusCode == 200) {
        //   await OpenFile.open(filePath);
        // }
      });
    } catch (e) {
      isDownload.value = false;
      download.value = 0;
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("حدث خطأ ما"),
      //   backgroundColor: Colors.red,
      //   duration: Duration(seconds: 1),
      // ));
      print(e);
    }
  }

  // Future<void> _downloadPDF(String linkpdf) async {
  //   Dio dio = Dio();
  //   String filename =
  //       linkpdf.split("/").last; // You can change the filename if needed

  //   try {
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String savePath = appDocDir.path + "/" + filename;

  //     await dio.download(
  //       linkpdf,
  //       savePath,
  //       onReceiveProgress: (received, total) {
  //         if (total != -1) {
  //           setState(() {
  //             _progress = (received / total * 100).toStringAsFixed(0) + "%";
  //           });
  //         }
  //       },
  //     );

  //     setState(() {
  //       _progress = "Download Completed";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  String execDecode(String code, String type) {
    var decoded = '';
    final splitSize = 4;
    RegExp exp = new RegExp(r"\d{" + "$splitSize" + "}");
    Iterable<Match> matches = exp.allMatches(code);
    List<String> sps = [];
    matches.forEach((element) {
      print(element.group(0));
      sps.add(element.group(0).toString());
    });
    print("myD From Browisng :$sps");

    var chars = {
      "6062": "0",
      "8439": "1",
      "9311": "2",
      "5685": "3",
      "8184": "4",
      "6670": "5",
      "9362": "6",
      "7585": "7",
      "1186": "8",
      "2587": "9",
      "6527": "a",
      "3620": "b",
      "2068": "c",
      "3282": "d",
      "9588": "e",
      "5628": "f",
      "1684": "g",
      "1256": "h",
      "6315": "i",
      "8328": "j",
      "1803": "k",
      "6757": "l",
      "3517": "m",
      "4178": "n",
      "1643": "o",
      "6793": "p",
      "7028": "q",
      "3805": "r",
      "9037": "s",
      "1744": "t",
      "4087": "u",
      "8558": "v",
      "3514": "w",
      "7418": "x",
      "9640": "y",
      "7215": "z",
      "3196": "A",
      "4495": "B",
      "7492": "C",
      "7588": "D",
      "8143": "E",
      "9643": "F",
      "1325": "G",
      "2526": "H",
      "2644": "I",
      "7343": "J",
      "4906": "K",
      "6111": "L",
      "8650": "M",
      "7736": "N",
      "5335": "O",
      "1806": "P",
      "8757": "Q",
      "6120": "R",
      "9962": "S",
      "3935": "T",
      "6140": "U",
      "8754": "V",
      "4545": "W",
      "6481": "X",
      "7552": "Y",
      "9888": "Z",
      "2342": "-",
      "7027": "_",
      "6422": "/",
      "7783": "?",
      "3795": "=",
      "8579": ".",
      "2466": ":",
    };
    List<String?> decodedList = [];
    for (var char in sps) {
      decodedList.add(chars[char]);
    }
    print('decodedList: $decodedList');
    decoded = decodedList.join();
    print('decoded: $decoded');

    switch (type) {
      case 'video':
        print('https://bayzin.com/uploads/videos/$decoded');
        return 'https://bayzin.com/uploads/videos/$decoded';
        break;
      case 'course':
        print('https://bayzin.com/uploads/courseware/$decoded');
        return 'https://bayzin.com/uploads/courseware/$decoded';
        break;
    }

    return '';
  }
}
