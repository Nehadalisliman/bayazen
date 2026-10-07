import 'package:e_learning/Controllers/course_ware_controller.dart';
import 'package:e_learning/Screens/celebrity/category/category_details_browsing.dart';
import 'package:e_learning/Screens/celebrity/courses/edit_courses_screen.dart';
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
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pagination/model/browse_course_model.dart';
import '../pagination/model/courses_model.dart';

const double borderRadius = 25.0;

class CategoryDetails extends StatefulWidget {
  //     ? isBrowsing
  final bool? isBrowsing;
  final int? celebId;
  //  ?End
  final String? programTitle;
  final String? categoryTitle;
  final int? categoryId;

  const CategoryDetails(
      {Key? key,
      this.programTitle,
      this.categoryTitle,
      this.categoryId,
      this.isBrowsing,
      this.celebId})
      : super(key: key);
  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int activePageIndex = 0;

  RxInt lastID = RxInt(-1);

  final PagingController<int, CourseData> _pagingController =
      PagingController(firstPageKey: 0);
  int x = 0;
  List<CourseData> categoryItems = [];
  bool isCourseLoading = false;
  bool isBrowseCourseLoading = false;
  getDataFromApi({int? lastId, required bool isFirst}) async {
    x++;
    var query = isFirst
        ? {"categoryId": widget.categoryId, "onlySome": true}
        : {"categoryId": widget.categoryId, "onlySome": true, "lastId": lastId};
    setState(() {
      isCourseLoading = true;
    });
    try {
      var response = await HelperDio.get(
        endpoint: 'courses',
        data: {
          "categoryId": widget.categoryId,
        },
        token: userToken,
      );

      if (response.statusCode == 200) {
        log("response 200");
        List<dynamic>? data = response.data['courses'];
        bool? last = response.data['Last'];
        categoryItems = [];
        log("Data" + data.toString());
        if (data != []) {
          data!.forEach((element) {
            categoryItems.add(CourseData.fromJson(element));
          });
          // var returnData = {'last': last, 'categories': categoryItems};
          isCourseLoading = false;
          setState(() {});
          // return returnData;
        }
      }
    } on DioException catch (e) {
      log("response error");
      setState(() {
        isCourseLoading = false;
      });
      log(e.response?.data);
    }

    // log("response ${response.data}");
  }

  List<BrowseCourseModel> browseCourseList = [];

  getDataFromApiBrowsing({int? lastId, required bool isFirst}) async {
    x++;
    log("Getting  Browsing  $x");

    var query = isFirst
        ? {
            "categoryId": widget.categoryId,
            "celebId": widget.celebId,
            "onlySome": true
          }
        : {
            "categoryId": widget.categoryId,
            "celebId": widget.celebId,
            "onlySome": true,
            "lastId": lastId
          };
    setState(() {
      isBrowseCourseLoading = true;
    });
    try {
      var response = await HelperDio.get(
          endpoint: 'browse/courses', data: query, token: userToken);
      log("Browse Coursers ${response.data}");
      if (response.statusCode == 200) {
        List<dynamic>? data = response.data['courses'];
        bool? last = response.data['Last'];
        browseCourseList = [];
        if (data != []) {
          data!.forEach((element) {
            browseCourseList.add(BrowseCourseModel.fromJson(element));
          });
          print(browseCourseList.length);
          isBrowseCourseLoading = false;
          setState(() {});
          // var returnData = {'last': last, 'categories': categoryItems};

          // return returnData;
        }
      }
    } on DioException catch (e) {
      log("response ${e.response?.data}");
      setState(() {
        isBrowseCourseLoading = false;
      });
    }
  }

  Future<void> fetchNewPage() async {
    bool? last;
    List<CourseData>? newItems;
    var data;
    try {
      if (lastID == -1) {
        log("First Category Details");
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
        lastID.value = newItems!.last.id!;
        log("lastID First $lastID");
        log("newItems.last.id;  ${newItems.last.id}");
        _pagingController.appendPage(newItems, lastID.value);
        return;
      }

      // First
      data = widget.isBrowsing!
          ? await getDataFromApiBrowsing(isFirst: false, lastId: lastID.value)
          : await getDataFromApi(isFirst: false, lastId: lastID.value);
      last = data['last'];
      //categories
      newItems = data['categories'];
      if (last!) {
        log("is Last Page");

        lastID.value = newItems!.last.id!;
        log("lastID  $lastID");
        log("newItems.last.id;  ${newItems.last.id}");
        _pagingController.appendLastPage(newItems);
        return;
      } else {
        log("is Not Last Page");

        lastID.value = newItems!.last.id!;
        log("lastID  $lastID");
        _pagingController.appendPage(newItems, lastID.value);
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
    super.initState();
    getDataFromApi(isFirst: true);
    getDataFromApiBrowsing(isFirst: true);
    lastID.value = -1;
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  widget.categoryTitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
                Obx(() {
                  if (isDownload.value) {
                    return Text(
                      " جاري التحميل " + download.toInt().toString() + "%",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo'),
                    );
                  }
                  return SizedBox(
                    width: 1,
                  );
                })
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
                child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                          () {
                            setState(() {
                              lastID.value = -1;
                              _pagingController.refresh();
                            });
                          },
                        ),
                    child: widget.isBrowsing!
                        ? isBrowseCourseLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : browseCourseList.isEmpty
                                ? Center(
                                    child: Text('لا يوجد كورسات'),
                                  )
                                : ListView.builder(
                                    itemCount: browseCourseList.length,
                                    itemBuilder: (context, index) {
                                      final browseItem =
                                          browseCourseList[index];
                                      return Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
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
                                                          text:
                                                              browseItem.title!,
                                                          fontSize: 20.sp,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      "ملف تعليمي",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 8.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                if (!widget.isBrowsing!)
                                                  IconButton(
                                                      onPressed: () async {
                                                        showDialog(
                                                            context: context,
                                                            builder: (c) => AlertDialog(
                                                                content: deleteWidget(
                                                                    course_id:
                                                                        browseItem
                                                                            .id)));
                                                      },
                                                      icon: Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                      )),
                                                if (!widget.isBrowsing!)
                                                  IconButton(
                                                      onPressed: () {
                                                        Get.to(EditCourseCleb(
                                                          title:
                                                              browseItem.title,
                                                          courseId:
                                                              browseItem.id,
                                                        ));
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .mode_edit_outlined,
                                                        color: Colors.blue,
                                                      )),
                                                IconButton(
                                                    onPressed: () async {
                                                      print(
                                                          'Link ${browseItem.link}');
                                                      Get.to(
                                                          CategoryDetailsBrowsing(
                                                        courseId: browseItem.id,
                                                        isBrowsing:
                                                            widget.isBrowsing,
                                                        courseTitle:
                                                            browseItem.title,
                                                        courseDescription: "",
                                                        courseLink:
                                                            browseItem.link ??
                                                                '',
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
                                      // : Column(
                                      //     children: [
                                      //       Container(
                                      //         margin: EdgeInsets.only(bottom: 10),
                                      //         decoration: BoxDecoration(
                                      //             color: Colors.grey.shade200,
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10)),
                                      //         padding: EdgeInsets.all(10),
                                      //         child: Row(
                                      //           children: [
                                      //             Column(
                                      //               crossAxisAlignment:
                                      //                   CrossAxisAlignment.start,
                                      //               children: [
                                      //                 SizedBox(
                                      //                   width: 160.w,
                                      //                   child: customText(
                                      //                       text: item.title!,
                                      //                       fontSize: 20.sp,
                                      //                       overflow:
                                      //                           TextOverflow.ellipsis,
                                      //                       fontWeight: FontWeight.w600),
                                      //                 ),
                                      //                 Text(
                                      //                   "ملف تعليمي",
                                      //                   style: TextStyle(
                                      //                       color: Colors.blue,
                                      //                       fontSize: 8.sp,
                                      //                       fontWeight: FontWeight.bold,
                                      //                       fontFamily: 'Cairo'),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //             Spacer(),
                                      //             if (!widget.isBrowsing!)
                                      //               IconButton(
                                      //                   onPressed: () async {
                                      //                     showDialog(
                                      //                         context: context,
                                      //                         builder: (c) => AlertDialog(
                                      //                             content: deleteWidget(
                                      //                                 course_id:
                                      //                                     item.id)));
                                      //                   },
                                      //                   icon: Icon(
                                      //                     Icons.delete_outline,
                                      //                     color: Colors.red,
                                      //                   )),
                                      //             if (!widget.isBrowsing!)
                                      //               IconButton(
                                      //                   onPressed: () {
                                      //                     Get.to(EditCourseCleb(
                                      //                       title: item.title,
                                      //                       courseId: item.id,
                                      //                     ));
                                      //                   },
                                      //                   icon: Icon(
                                      //                     Icons.mode_edit_outlined,
                                      //                     color: Colors.blue,
                                      //                   )),
                                      //             IconButton(
                                      //                 onPressed: () async {
                                      //                   print('Link ${item.link}');
                                      //                   Get.to(CategoryDetailsBrowsing(
                                      //                     courseId: item.id,
                                      //                     isBrowsing: widget.isBrowsing,
                                      //                     courseTitle: item.title,
                                      //                     courseDescription: "",
                                      //                     courseLink: item.link ?? '',
                                      //                   ));
                                      //                 },
                                      //                 icon: Icon(
                                      //                   Icons.visibility,
                                      //                   color: Colors.grey,
                                      //                 ))
                                      //           ],
                                      //         ),
                                      //       )
                                      //     ],
                                      //   );
                                    },
                                  )
                        : isCourseLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : categoryItems.isEmpty
                                ? Center(
                                    child: Text('لا يوجد كورسات'),
                                  )
                                : ListView.builder(
                                    itemCount: categoryItems.length,
                                    itemBuilder: (context, index) {
                                      final browseItem = categoryItems[index];
                                      return Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
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
                                                          text:
                                                              browseItem.title!,
                                                          fontSize: 20.sp,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      "ملف تعليمي",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 8.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                if (!widget.isBrowsing!)
                                                  IconButton(
                                                      onPressed: () async {
                                                        showDialog(
                                                            context: context,
                                                            builder: (c) => AlertDialog(
                                                                content: deleteWidget(
                                                                    course_id:
                                                                        browseItem
                                                                            .id)));
                                                      },
                                                      icon: Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                      )),
                                                if (!widget.isBrowsing!)
                                                  IconButton(
                                                      onPressed: () {
                                                        Get.to(EditCourseCleb(
                                                          title:
                                                              browseItem.title,
                                                          courseId:
                                                              browseItem.id,
                                                        ));
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .mode_edit_outlined,
                                                        color: Colors.blue,
                                                      )),
                                                IconButton(
                                                    onPressed: () async {
                                                      print(
                                                          'Link ${browseItem.link}');
                                                      Get.to(
                                                          CategoryDetailsBrowsing(
                                                        courseId: browseItem.id,
                                                        isBrowsing:
                                                            widget.isBrowsing,
                                                        courseTitle:
                                                            browseItem.title,
                                                        courseDescription: "",
                                                        courseLink:
                                                            browseItem.link ??
                                                                '',
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
                                      // : Column(
                                      //     children: [
                                      //       Container(
                                      //         margin: EdgeInsets.only(bottom: 10),
                                      //         decoration: BoxDecoration(
                                      //             color: Colors.grey.shade200,
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10)),
                                      //         padding: EdgeInsets.all(10),
                                      //         child: Row(
                                      //           children: [
                                      //             Column(
                                      //               crossAxisAlignment:
                                      //                   CrossAxisAlignment.start,
                                      //               children: [
                                      //                 SizedBox(
                                      //                   width: 160.w,
                                      //                   child: customText(
                                      //                       text: item.title!,
                                      //                       fontSize: 20.sp,
                                      //                       overflow:
                                      //                           TextOverflow.ellipsis,
                                      //                       fontWeight: FontWeight.w600),
                                      //                 ),
                                      //                 Text(
                                      //                   "ملف تعليمي",
                                      //                   style: TextStyle(
                                      //                       color: Colors.blue,
                                      //                       fontSize: 8.sp,
                                      //                       fontWeight: FontWeight.bold,
                                      //                       fontFamily: 'Cairo'),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //             Spacer(),
                                      //             if (!widget.isBrowsing!)
                                      //               IconButton(
                                      //                   onPressed: () async {
                                      //                     showDialog(
                                      //                         context: context,
                                      //                         builder: (c) => AlertDialog(
                                      //                             content: deleteWidget(
                                      //                                 course_id:
                                      //                                     item.id)));
                                      //                   },
                                      //                   icon: Icon(
                                      //                     Icons.delete_outline,
                                      //                     color: Colors.red,
                                      //                   )),
                                      //             if (!widget.isBrowsing!)
                                      //               IconButton(
                                      //                   onPressed: () {
                                      //                     Get.to(EditCourseCleb(
                                      //                       title: item.title,
                                      //                       courseId: item.id,
                                      //                     ));
                                      //                   },
                                      //                   icon: Icon(
                                      //                     Icons.mode_edit_outlined,
                                      //                     color: Colors.blue,
                                      //                   )),
                                      //             IconButton(
                                      //                 onPressed: () async {
                                      //                   print('Link ${item.link}');
                                      //                   Get.to(CategoryDetailsBrowsing(
                                      //                     courseId: item.id,
                                      //                     isBrowsing: widget.isBrowsing,
                                      //                     courseTitle: item.title,
                                      //                     courseDescription: "",
                                      //                     courseLink: item.link ?? '',
                                      //                   ));
                                      //                 },
                                      //                 icon: Icon(
                                      //                   Icons.visibility,
                                      //                   color: Colors.grey,
                                      //                 ))
                                      //           ],
                                      //         ),
                                      //       )
                                      //     ],
                                      //   );
                                    },
                                  )

                    // isCourseLoading
                    //     ? Center(
                    //         child: CircularProgressIndicator(),
                    //       )
                    //     : categoryItems.isEmpty
                    //         ? Center(
                    //             child: Text('لا يوجد كورسات'),
                    //           )
                    //         :
                    // ListView.builder(
                    //             itemCount: widget.isBrowsing!
                    //                 ? browseCourseList.length
                    //                 : categoryItems.length,
                    //             itemBuilder: (context, index) {
                    //               final item = categoryItems[index];
                    //               final browseItem = browseCourseList[index];
                    //               return widget.isBrowsing!
                    //                   ? Column(
                    //                       children: [
                    //                         Container(
                    //                           margin:
                    //                               EdgeInsets.only(bottom: 10),
                    //                           decoration: BoxDecoration(
                    //                               color: Colors.grey.shade200,
                    //                               borderRadius:
                    //                                   BorderRadius.circular(
                    //                                       10)),
                    //                           padding: EdgeInsets.all(10),
                    //                           child: Row(
                    //                             children: [
                    //                               Column(
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment
                    //                                         .start,
                    //                                 children: [
                    //                                   SizedBox(
                    //                                     width: 160.w,
                    //                                     child: customText(
                    //                                         text: item.title!,
                    //                                         fontSize: 20.sp,
                    //                                         overflow:
                    //                                             TextOverflow
                    //                                                 .ellipsis,
                    //                                         fontWeight:
                    //                                             FontWeight
                    //                                                 .w600),
                    //                                   ),
                    //                                   Text(
                    //                                     "ملف تعليمي",
                    //                                     style: TextStyle(
                    //                                         color: Colors.blue,
                    //                                         fontSize: 8.sp,
                    //                                         fontWeight:
                    //                                             FontWeight.bold,
                    //                                         fontFamily:
                    //                                             'Cairo'),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               Spacer(),
                    //                               if (!widget.isBrowsing!)
                    //                                 IconButton(
                    //                                     onPressed: () async {
                    //                                       showDialog(
                    //                                           context: context,
                    //                                           builder: (c) => AlertDialog(
                    //                                               content: deleteWidget(
                    //                                                   course_id:
                    //                                                       item.id)));
                    //                                     },
                    //                                     icon: Icon(
                    //                                       Icons.delete_outline,
                    //                                       color: Colors.red,
                    //                                     )),
                    //                               if (!widget.isBrowsing!)
                    //                                 IconButton(
                    //                                     onPressed: () {
                    //                                       Get.to(EditCourseCleb(
                    //                                         title: item.title,
                    //                                         courseId: item.id,
                    //                                       ));
                    //                                     },
                    //                                     icon: Icon(
                    //                                       Icons
                    //                                           .mode_edit_outlined,
                    //                                       color: Colors.blue,
                    //                                     )),
                    //                               IconButton(
                    //                                   onPressed: () async {
                    //                                     print(
                    //                                         'Link ${item.link}');
                    //                                     Get.to(
                    //                                         CategoryDetailsBrowsing(
                    //                                       courseId:
                    //                                           browseItem.id,
                    //                                       isBrowsing:
                    //                                           widget.isBrowsing,
                    //                                       courseTitle:
                    //                                           browseItem.title,
                    //                                       courseDescription: "",
                    //                                       courseLink:
                    //                                           browseItem.link ??
                    //                                               '',
                    //                                     ));
                    //                                   },
                    //                                   icon: Icon(
                    //                                     Icons.visibility,
                    //                                     color: Colors.grey,
                    //                                   ))
                    //                             ],
                    //                           ),
                    //                         )
                    //                       ],
                    //                     )
                    //                   : Column(
                    //                       children: [
                    //                         Container(
                    //                           margin:
                    //                               EdgeInsets.only(bottom: 10),
                    //                           decoration: BoxDecoration(
                    //                               color: Colors.grey.shade200,
                    //                               borderRadius:
                    //                                   BorderRadius.circular(
                    //                                       10)),
                    //                           padding: EdgeInsets.all(10),
                    //                           child: Row(
                    //                             children: [
                    //                               Column(
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment
                    //                                         .start,
                    //                                 children: [
                    //                                   SizedBox(
                    //                                     width: 160.w,
                    //                                     child: customText(
                    //                                         text: item.title!,
                    //                                         fontSize: 20.sp,
                    //                                         overflow:
                    //                                             TextOverflow
                    //                                                 .ellipsis,
                    //                                         fontWeight:
                    //                                             FontWeight
                    //                                                 .w600),
                    //                                   ),
                    //                                   Text(
                    //                                     "ملف تعليمي",
                    //                                     style: TextStyle(
                    //                                         color: Colors.blue,
                    //                                         fontSize: 8.sp,
                    //                                         fontWeight:
                    //                                             FontWeight.bold,
                    //                                         fontFamily:
                    //                                             'Cairo'),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               Spacer(),
                    //                               if (!widget.isBrowsing!)
                    //                                 IconButton(
                    //                                     onPressed: () async {
                    //                                       showDialog(
                    //                                           context: context,
                    //                                           builder: (c) => AlertDialog(
                    //                                               content: deleteWidget(
                    //                                                   course_id:
                    //                                                       item.id)));
                    //                                     },
                    //                                     icon: Icon(
                    //                                       Icons.delete_outline,
                    //                                       color: Colors.red,
                    //                                     )),
                    //                               if (!widget.isBrowsing!)
                    //                                 IconButton(
                    //                                     onPressed: () {
                    //                                       Get.to(EditCourseCleb(
                    //                                         title: item.title,
                    //                                         courseId: item.id,
                    //                                       ));
                    //                                     },
                    //                                     icon: Icon(
                    //                                       Icons
                    //                                           .mode_edit_outlined,
                    //                                       color: Colors.blue,
                    //                                     )),
                    //                               IconButton(
                    //                                   onPressed: () async {
                    //                                     print(
                    //                                         'Link ${item.link}');
                    //                                     Get.to(
                    //                                         CategoryDetailsBrowsing(
                    //                                       courseId: item.id,
                    //                                       isBrowsing:
                    //                                           widget.isBrowsing,
                    //                                       courseTitle:
                    //                                           item.title,
                    //                                       courseDescription: "",
                    //                                       courseLink:
                    //                                           item.link ?? '',
                    //                                     ));
                    //                                   },
                    //                                   icon: Icon(
                    //                                     Icons.visibility,
                    //                                     color: Colors.grey,
                    //                                   ))
                    //                             ],
                    //                           ),
                    //                         )
                    //                       ],
                    //                     );
                    //             },
                    //           )

                    // PagedListView<int, CourseData>(
                    //   pagingController: _pagingController,
                    //   builderDelegate: PagedChildBuilderDelegate<CourseData>(
                    //       noItemsFoundIndicatorBuilder: ((context) => Center(
                    //               child: Text(
                    //             "لايوجد مناهج كورسات",
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
                    //         // print("item ${item.categoryId}");
                    //         // print("item ${item.title}");
                    //         // print("item ${item.id}");
                    //         // print("item ${item.link}");
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
                    //                             fontSize: 20.sp,
                    //                             overflow: TextOverflow.ellipsis,
                    //                             fontWeight: FontWeight.w600),
                    //                       ),
                    //                       Text(
                    //                         "ملف تعليمي",
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
                    //                         onPressed: () async {
                    //                           showDialog(
                    //                               context: context,
                    //                               builder: (c) => AlertDialog(
                    //                                   content: deleteWidget(
                    //                                       course_id: item.id)));
                    //                         },
                    //                         icon: Icon(
                    //                           Icons.delete_outline,
                    //                           color: Colors.red,
                    //                         )),
                    //                   if (!widget.isBrowsing!)
                    //                     IconButton(
                    //                         onPressed: () {
                    //                           Get.to(EditCourseCleb(
                    //                             title: item.title,
                    //                             courseId: item.id,
                    //                           ));
                    //                         },
                    //                         icon: Icon(
                    //                           Icons.mode_edit_outlined,
                    //                           color: Colors.blue,
                    //                         )),
                    //                   IconButton(
                    //                       onPressed: () async {
                    //                         print('Link ${item.link}');
                    //                         Get.to(CategoryDetailsBrowsing(
                    //                           courseId: item.id,
                    //                           isBrowsing: widget.isBrowsing,
                    //                           courseTitle: item.title,
                    //                           courseDescription: "",
                    //                           courseLink: item.link ?? '',
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

                    )),
          ],
        ),
      ),
    );
  }

  RxDouble download = RxDouble(0);
  RxBool isDownload = RxBool(false);

  dawnloadFile({required String link, String? name}) async {
    Dio dio = Dio();
    try {
      isDownload.value = true;
      download.value = 0;
      var dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/$name";
      await dio.download(link, filePath, onReceiveProgress: (rec, total) {
        log("Rec: $rec , Total: $total");
        log("download${download.value.toDouble()}");
        download.value = (rec.toDouble() / total.toDouble()) * 100;
      }).then((value) async {
        isDownload.value = false;
        if (value.statusCode == 200) {
          await OpenFile.open(filePath);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Container deleteWidget({int? course_id}) {
    return Container(
      height: 100.h,
      width: 50.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.sp)),
      child: Obx(() {
        if (courseWareController.isCourseDeleted.value) {
          return Center(
            child: Text(
              "جاري الحذف",
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "هل تريد حذف الكورس؟",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () async {
                      await courseWareController.deleteCourse(
                          course_id: course_id);
                      setState(() {
                        lastID.value = -1;
                        _pagingController.refresh();
                      });
                      Get.back();
                    },
                    child: Text(
                      "نعم",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Cairo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "لا",
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Cairo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            )
          ],
        );
      }),
    );
  }
}
