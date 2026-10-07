import 'package:e_learning/Controllers/course_ware_controller.dart';
import 'package:e_learning/Screens/celebrity/chapters/chapter_video_details.dart';
import 'package:e_learning/Screens/celebrity/chapters/chapter_video_details_browsing.dart';
import 'package:e_learning/Screens/celebrity/pagination/model/chapter_videos.dart';
import 'package:e_learning/core/helpers/helper_dio.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_learning/core/helpers/dio_helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterVideosScreen extends StatefulWidget {
  //     ? isBrowsing
  final bool? isBrowsing;
  final int? celebId;
  //  ?End
  final String? chapterName;
  final int? chapterId;
  ChapterVideosScreen(
      {Key? key,
      this.chapterName,
      this.chapterId,
      this.isBrowsing,
      this.celebId})
      : super(key: key);

  @override
  State<ChapterVideosScreen> createState() => _ChapterVideosScreenState();
}

class _ChapterVideosScreenState extends State<ChapterVideosScreen> {
  PageController? _pageController;

  int activePageIndex = 0;

  int? lastID;

  final PagingController<int, ChapterVideos> _pagingController =
      PagingController(firstPageKey: 0);

  int x = 0;

  getDataFromApi({int? lastId, required bool isFirst}) async {
    x++;

    var query = isFirst
        ? {"chapterId": widget.chapterId, "onlySome": true}
        : {"chapterId": widget.chapterId, "onlySome": true, "lastId": lastId};
    var response = await HelperDio.get(
        endpoint: 'video/chapter-videos',
        data: {"chapterId": widget.chapterId},
        token: userToken);

    if (response.statusCode == 200) {
      log("response ${response.data}");
      log("response 200");
      List<dynamic>? data = response.data['videos'];
      bool? last = response.data['Last'];
      List<ChapterVideos> chapterVideos = [];
      if (data != []) {
        data!.forEach((element) {
          chapterVideos.add(ChapterVideos.fromJson(element));
        });
        var returnData = {'last': last, 'videos': chapterVideos};
        setState(() {});
        return returnData;
      } else {
        log("response error");
        // server error
        return Future.error("Server Error !");
      }
    }
  }

  getDataFromApiBrowsing({int? lastId, required bool isFirst}) async {
    x++;
    print("Getting chapter Video Browsing  $x");

    log("Start res");
    log("chapterId: ${widget.chapterId}");
    log("chapterId: ${widget.celebId}");
    log("ISFirst : $isFirst");

    var query = isFirst
        ? {
            "lastId": 0,
            "chapterId": widget.chapterId,
            "celebId": widget.celebId,
            "onlySome": true
          }
        : {
            "chapterId": widget.chapterId,
            "celebId": widget.celebId,
            "onlySome": true,
            "lastId": lastId
          };

    var response = await HelperDio.get(
        endpoint: 'browse/videos',
        data: {
          "chapterId": widget.chapterId,
          "celebId": widget.celebId,
        },
        token: userToken);

    if (response.statusCode == 200) {
      log("response Chapter Video Browsing ${response.data}");
      log("response 200");
      List<dynamic>? data = response.data['videos'];
      bool? last = response.data['Last'];
      List<ChapterVideos> categoryItems = [];
      if (data != []) {
        data!.forEach((element) {
          categoryItems.add(ChapterVideos.fromJson(element));
        });
        var returnData = {'last': last, 'videos': categoryItems};

        return returnData;
      } else {
        log("response error");
        // server error
        return Future.error("Server Error !");
      }
    }
  }

  Future<void> fetchNewPage() async {
    bool? last;
    List<ChapterVideos>? newItems;
    var data;
    try {
      if (lastID == -1) {
        log("First");
        data = widget.isBrowsing!
            ? await getDataFromApiBrowsing(isFirst: true, lastId: 0)
            : await getDataFromApi(isFirst: true, lastId: 0);
        last = data['last'];
        //categories
        newItems = data['videos'];

        if (last!) {
          _pagingController.appendLastPage(newItems!);
          return;
        }
        lastID = newItems!.last.id;
        log("lastID $lastID");
        _pagingController.appendPage(newItems, lastID);
        return;
      }

      // First
      data = widget.isBrowsing!
          ? await getDataFromApiBrowsing(isFirst: false, lastId: lastID)
          : await getDataFromApi(isFirst: false, lastId: lastID);
      last = data['last'];
      //categories
      newItems = data['videos'];
      if (last!) {
        log("is Last Page");

        lastID = newItems!.last.id;
        log("lastID  $lastID");
        _pagingController.appendLastPage(newItems);
        return;
      } else {
        log("is Not Last Page");

        lastID = newItems!.last.id;
        log("lastID  $lastID");
        _pagingController.appendPage(newItems, lastID);
        return;
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // getDataFromApi(isFirst: true);
    // getDataFromApiBrowsing(isFirst: true);
    lastID = -1;
    _pageController = PageController();
    _pagingController.addPageRequestListener((page) {
      fetchNewPage();
    });
  }

  var courseWareController = Get.put(CourseWareController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.chapterName!,
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 15.h,
            ),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () {
                  setState(() {
                    lastID = -1;
                    _pagingController.refresh();
                  });
                },
              ),
              child: PagedListView<int, ChapterVideos>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ChapterVideos>(
                    noItemsFoundIndicatorBuilder: ((context) => Center(
                            child: Text(
                          "لايوجد فيديوهات",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ))),
                    firstPageErrorIndicatorBuilder: ((context) => Center(
                            child: Text(
                          "حدث خطأ",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ))),
                    newPageErrorIndicatorBuilder: (context) => Center(
                        child: Text(
                      "حدث خطأ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
                    itemBuilder: (context, item, index) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.isBrowsing!) {
                            log(item.title!);
                            log(item.id.toString());
                            log(item.description!);
                            // log(item.link!);
                            Get.to(ChapterVideoDetailsBrowsing(
                              videoId: item.id,
                              videoUrl: item.link,
                              videoTitle: item.title,
                              videoDescription: item.description,
                            ));
                          } else {
                            print(item.link);
                            Get.to(ChapterVideoDetails(
                              isBrowing: widget.isBrowsing,
                              videoId: item.id,
                              videoLink: item.link,
                              videoTitle: item.title,
                              videoDescription: item.description,
                            ));
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  //width: 80.w,
                                  child: Text(
                                    item.title!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                /*  SizedBox(
                                  //width: 80.w,
                                  child: Text(
                                    item.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                            Container(
                                height: 80.h,
                                width: 80.w,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(5.sp)),
                                padding: EdgeInsets.all(5.sp),
                                child: Icon(
                                  Icons.play_circle,
                                  size: 35.sp,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      );
                    },
                  )),
            )),
          ],
        ),
      ),
    );
  }
}
