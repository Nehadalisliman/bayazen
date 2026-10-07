import 'package:e_learning/Controllers/browsing_controller.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Screens/celebrity/store/video_story.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Screens/student/comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ChapterVideoDetails extends StatefulWidget {
  final bool? isBrowing;
  final int? videoId;
  String? videoLink;

  final String? videoTitle;
  final String? videoDescription;

  ChapterVideoDetails(
      {Key? key,
      this.videoLink,
      this.videoTitle,
      this.videoDescription,
      this.isBrowing = false,
      this.videoId})
      : super(key: key);

  @override
  State<ChapterVideoDetails> createState() => _ChapterVideoDetailsState();
}

class _ChapterVideoDetailsState extends State<ChapterVideoDetails> {
  // controller le Profile
  var teacherController = Get.put(CelebController());

  var browsingController = Get.put(BrowsingController());

  VideoPlayerController? _controller;

  String? name;

  @override
  void initState() {
    name = teacherController.celebrityResponseModel.name ?? '';
    getVideo();
    super.initState();
  }

  getVideo() async {
    // browsingController.getCelebVideoBrowsing(celebId: 8, chapterId: 20);
    // String link = browsingController.videoBrwosing.link!;
    // print("Link $link");
    // videoUrl = execDecode(link, 'video');
    print("videoUrl ${widget.videoLink}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'الفيديو',
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
            // browsingController.getCelebVideoBrowsing(celebId: 8, chapterId: 20);
            // String link = browsingController.videoBrwosing.link!;
            // print("Link $link");
            // widget.videoLink = execDecode(link, 'video');
            // print("videoUrl ${widget.videoLink}");
            // return Future.value(true);
          },
          child: ListView(children: [
            // Obx(() {
            //   if (browsingController.isVideoLoading.value) {
            //     return Column(
            //       children: [
            //         SizedBox(height: 250.h),
            //         GlobalLoading(),
            //       ],
            //     );
            //   }

            //   return
            SizedBox(
                height: 1.sh,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // videoUrl == "https://bayzin.com/uploads/videos/"
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
                      textDirection: TextDirection.ltr,
                      child: VideoStory(
                        videoUrl: widget.videoLink,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(widget.videoTitle!,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(widget.videoDescription!,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                            teacherController
                                .celebrityResponseModel.specialization!,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10.sp,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading:
                              teacherController.celebrityResponseModel.image !=
                                      ''
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          teacherController
                                              .celebrityResponseModel.image!),
                                    )
                                  : SizedBox()),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // if (widget.videoLink !=
                    //     "https://bayzin.com/uploads/videos/")
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: MaterialButton(
                          minWidth: 100.w,
                          height: 50.h,
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r)),
                          onPressed: () {
                            Get.to(CommentScreen(video_ID: widget.videoId!));
                          },
                          child: Text(
                            "التعليقات",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ))
            // })
          ]),
        ));
  }

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
