import 'package:e_learning/Controllers/course_ware_controller.dart';
import 'package:e_learning/Screens/celebrity/chapters/chapter_videos.dart';
import 'package:e_learning/Screens/celebrity/chapters/edit_chapter.dart';
import 'package:e_learning/Screens/celebrity/pagination/model/category_data.dart';
import 'package:e_learning/core/helpers/helper_dio.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_learning/Widgets/custom_text.dart';
import 'package:e_learning/core/helpers/dio_helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pagination/model/browse_chapters_model.dart';

const double borderRadius = 25.0;

class ChapterDetails extends StatefulWidget {
  //     ? isBrowsing
  final bool? isBrowsing;
  final int? celebId;
  //  ?End
  final String? libraryName;
  final String? programTitle;
  final int? programId;

  const ChapterDetails(
      {Key? key,
      this.programId,
      this.libraryName,
      this.programTitle,
      this.isBrowsing,
      this.celebId})
      : super(key: key);
  @override
  _ChapterDetailsState createState() => _ChapterDetailsState();
}

class _ChapterDetailsState extends State<ChapterDetails>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int activePageIndex = 0;

  int? lastID;

  final PagingController<int, CategoryData> _pagingController =
      PagingController(firstPageKey: 0);
  int x = 0;
  List<CategoryData> categoryItems = [];
  bool chapterLoading = false;
  getDataFromApi({int? lastId, required bool isFirst}) async {
    x++;
    log("Getting More Data  $x");
    var query = isFirst
        ? {
            "libraryName": widget.libraryName,
            "programId": widget.programId,
            "onlySome": true
          }
        : {
            "libraryName": widget.libraryName,
            "programId": widget.programId,
            "onlySome": true,
            "lastId": lastId
          };
    setState(() {
      chapterLoading = true;
    });
    try {
      var response = await HelperDio.get(
        endpoint: 'chapters',
        data: {
          "libraryName": widget.libraryName,
          "programId": widget.programId,
        },
        token: userToken,
      );
      if (response.statusCode == 200) {
        // log("response data ${response.data['chapters']}");
        List<dynamic> data = response.data['chapters'];

        categoryItems = [];
        print(categoryItems.length);
        bool? last = response.data['Last'];

        if (data != []) {
          data!.forEach((element) {
            categoryItems.add(CategoryData.fromJson(element));
          });
          print("Categorrrrry ${categoryItems.length}");
          var returnData = {'last': last, 'categories': categoryItems};
          chapterLoading = false;
          setState(() {});
          return returnData;
        }
      }
    } on DioException catch (e) {
      log(e.response?.data);
      chapterLoading = false;
      setState(() {});
    }
  }

  List<BrowseChapterModel> browseChapterList = [];
  bool browseChapterLoading = false;

  getDataFromApiBrowsing({int? lastId, required bool isFirst}) async {
    x++;

    var query = isFirst
        ? {
            "libraryName": widget.libraryName,
            "programId": widget.programId,
            "celebId": widget.celebId,
            "onlySome": true,
          }
        : {
            "libraryName": widget.libraryName,
            "programId": widget.programId,
            "celebId": widget.celebId,
            "onlySome": true,
            "lastId": lastId,
          };
    browseChapterLoading = true;
    setState(() {});
    try {
      var response = await HelperDio.get(
        endpoint: 'browse/chapters',
        data: query,
        token: userToken,
      );

      log("response Browsing Chapter $response");

      if (response.statusCode == 200) {
        log("response 200");
        List<dynamic>? data = response.data['chapters'];
        // bool? last = response.data['Last'];
        browseChapterList = [];
        if (data != []) {
          data!.forEach((element) {
            browseChapterList.add(BrowseChapterModel.fromJson(element));
          });
          browseChapterLoading = false;
          setState(() {});
          // var returnData = {'last': last, 'categories': browseChapterList};
          // return returnData;
        }
      }
    } on DioException catch (e) {
      log(e.response?.data);
      browseChapterLoading = false;
      setState(() {});
    }
  }

  Future<void> fetchNewPage() async {
    bool? last;
    List<CategoryData>? newItems;
    var data;
    try {
      if (lastID == -1) {
        log("First");
        data = widget.isBrowsing!
            ? await getDataFromApiBrowsing(isFirst: true, lastId: 0)
            : await getDataFromApi(isFirst: true, lastId: 0);
        last = data['last'];
        //categories
        newItems = data['categories'];

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
      newItems = data['categories'];
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // getDataFromApi(isFirst: true);
    getDataFromApiBrowsing(isFirst: true);
    super.initState();
    lastID = -1;
    _pageController = PageController();
    _pagingController.addPageRequestListener((page) {
      fetchNewPage();
    });
  }

  var courseWareController = Get.put(CourseWareController());

  @override
  Widget build(BuildContext context) {
    print("LibName ${widget.libraryName}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'منهج ${widget.programTitle}',
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
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: widget.isBrowsing!
            ? browseChapterLoading
                ? Center(child: CircularProgressIndicator())
                : browseChapterList.isEmpty
                    ? Center(
                        child: Text('لا يوجد منهج'),
                      )
                    : ListView.builder(
                        itemCount: browseChapterList.length,
                        itemBuilder: (context, index) {
                          final item = browseChapterList[index];
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 160.w,
                                          child: customText(
                                              text: item.title!,
                                              fontSize: 12.sp,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          item.description!,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo'),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    if (!widget.isBrowsing!)
                                      IconButton(
                                          onPressed: () {
                                            //  Edit Chapter
                                            Get.to(EditChapter(
                                              title: item.title,
                                              description: item.description,
                                              chapterId: item.id,
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.mode_edit_outlined,
                                            color: Colors.blue,
                                          )),
                                    IconButton(
                                        onPressed: () {
                                          Get.to(ChapterVideosScreen(
                                            celebId: widget.celebId,
                                            isBrowsing: widget.isBrowsing,
                                            chapterId: item.id,
                                            chapterName: item.title,
                                          ));
                                        },
                                        icon: Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      )
            : chapterLoading
                ? Center(child: CircularProgressIndicator())
                : categoryItems.isEmpty
                    ? Center(
                        child: Text('لا يوجد منهج'),
                      )
                    : ListView.builder(
                        itemCount: categoryItems.length,
                        itemBuilder: (context, index) {
                          final item = categoryItems[index];
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 160.w,
                                          child: customText(
                                              text: item.title!,
                                              fontSize: 12.sp,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          item.description!,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo'),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    if (!widget.isBrowsing!)
                                      IconButton(
                                          onPressed: () {
                                            //  Edit Chapter
                                            Get.to(EditChapter(
                                              title: item.title,
                                              description: item.description,
                                              chapterId: item.id,
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.mode_edit_outlined,
                                            color: Colors.blue,
                                          )),
                                    IconButton(
                                        onPressed: () {
                                          Get.to(ChapterVideosScreen(
                                            celebId: widget.celebId,
                                            isBrowsing: widget.isBrowsing,
                                            chapterId: item.id,
                                            chapterName: item.title,
                                          ));
                                        },
                                        icon: Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),

        // PagedListView<int, CategoryData>(
        //   pagingController: _pagingController,
        //   builderDelegate: PagedChildBuilderDelegate<CategoryData>(
        //       noItemsFoundIndicatorBuilder: ((context) => Center(
        //               child: Text(
        //             "لايوجد مناهج شباتر",
        //             style: TextStyle(
        //               fontSize: 15.sp,
        //               fontFamily: 'Cairo',
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //             ),
        //           ))),
        //       firstPageErrorIndicatorBuilder: ((context) => Center(
        //               child: Text(
        //             "حدث خطأ",
        //             style: TextStyle(
        //               fontSize: 15.sp,
        //               fontFamily: 'Cairo',
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //             ),
        //           ))),
        //       newPageErrorIndicatorBuilder: (context) => Center(
        //               child: Text(
        //             "حدث خطأ",
        //             style: TextStyle(
        //               fontSize: 15.sp,
        //               fontFamily: 'Cairo',
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //             ),
        //           )),
        //       itemBuilder: (context, item, index) {
        //         return Column(
        //           children: [
        //             Container(
        //               margin: EdgeInsets.only(bottom: 10),
        //               decoration: BoxDecoration(
        //                   color: Colors.grey.shade200,
        //                   borderRadius: BorderRadius.circular(10)),
        //               padding: EdgeInsets.all(10),
        //               child: Row(
        //                 children: [
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       SizedBox(
        //                         width: 160.w,
        //                         child: customText(
        //                             text: item.title!,
        //                             fontSize: 12.sp,
        //                             overflow: TextOverflow.ellipsis,
        //                             fontWeight: FontWeight.w600),
        //                       ),
        //                       Text(
        //                         item.description!,
        //                         style: TextStyle(
        //                             color: Colors.blue,
        //                             fontSize: 8.sp,
        //                             fontWeight: FontWeight.bold,
        //                             fontFamily: 'Cairo'),
        //                       ),
        //                     ],
        //                   ),
        //                   Spacer(),
        //                   if (!widget.isBrowsing!)
        //                     IconButton(
        //                         onPressed: () {
        //                           //  Edit Chapter
        //                           Get.to(EditChapter(
        //                             title: item.title,
        //                             description: item.description,
        //                             chapterId: item.id,
        //                           ));
        //                         },
        //                         icon: Icon(
        //                           Icons.mode_edit_outlined,
        //                           color: Colors.blue,
        //                         )),
        //                   IconButton(
        //                       onPressed: () {
        //                         Get.to(ChapterVideosScreen(
        //                           celebId: widget.celebId,
        //                           isBrowsing: widget.isBrowsing,
        //                           chapterId: item.id,
        //                           chapterName: item.title,
        //                         ));
        //                       },
        //                       icon: Icon(
        //                         Icons.visibility,
        //                         color: Colors.grey,
        //                       ))
        //                 ],
        //               ),
        //             )
        //           ],
        //         );

        //       }),
        // ),
      ),
    );
  }
}
