// StoryProfile

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning/Controllers/celeb/story_controller.dart';
import 'package:e_learning/Screens/celebrity/store/edit_story.dart';
import 'package:e_learning/Screens/celebrity/store/image_viewer.dart';
import 'package:e_learning/Screens/celebrity/store/model/story_model.dart';
import 'package:e_learning/Screens/celebrity/store/video_story.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_learning/core/helpers/dio_helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helpers/helper_dio.dart';
import '../../../core/shared_pref.dart';

const double borderRadius = 25.0;

class StoryProfile extends StatefulWidget {
  //     ? isBrowsing
  final bool? isBrowsing;
  final int? celebId;
  //  ?End

  const StoryProfile({Key? key, this.isBrowsing, this.celebId})
      : super(key: key);
  @override
  _StoryProfileState createState() => _StoryProfileState();
}

class _StoryProfileState extends State<StoryProfile>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int activePageIndex = 0;
  StoryController storyController = Get.put(StoryController());

  int? lastID;

  final PagingController<int, StoryModel> _pagingController =
      PagingController(firstPageKey: 0);
  int x = 0;
  getDataFromApi({int? lastId, required bool isFirst}) async {
    x++;

    log("Start res");
    var query = isFirst
        ? {"celebId": userID, "onlySome": true}
        : {"celebId": userID, "onlySome": true, "lastId": lastId};

    // var response = await DioHelper.getData(
    //     url: 'https://bayzin.com/api/browse/stories',
    //     query: query,
    //     token: token);

    var response = await HelperDio.get(
      endpoint: 'browse/stories',
      data: query,
      token: userToken,
    );
    log("response $response");

    if (response.statusCode == 200) {
      List<dynamic>? data = response.data['stories'];

      bool? last = response.data['Last'];
      List<StoryModel> categoryItems = [];

      if (data != []) {
        log("DATA ${data}");
        data!.forEach((element) {
          StoryModel d = StoryModel.fromJson(element);

          categoryItems.add(d);
        });
        var returnData = {'last': last, 'stories': categoryItems};

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
    print("Getting Browsing Chapter  $x");
    print(widget.celebId);
    var query = isFirst
        ? {"onlySome": true, "celebId": widget.celebId}
        : {"onlySome": true, "lastId": lastId, "celebId": widget.celebId};

    // var response = await DioHelper.getData(
    //     url: 'https://bayzin.com/api/browse/stories',
    //     query: query,
    //     token: token);
    var response = await HelperDio.get(
      endpoint: 'browse/stories',
      data: query,
      token: userToken,
    );

    log("response Browsing Chapter $response");

    if (response.statusCode == 200) {
      log("response 200");
      List<dynamic>? data = response.data['stories'];
      bool? last = response.data['Last'];
      List<StoryModel> categoryItems = [];
      if (data != []) {
        data!.forEach((element) {
          categoryItems.add(StoryModel.fromJson(element));
        });
        var returnData = {'last': last, 'stories': categoryItems};

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
    List<StoryModel>? newItems;
    var data;
    try {
      if (lastID == -1) {
        log("First");
        data = widget.isBrowsing!
            ? await getDataFromApiBrowsing(isFirst: true, lastId: 0)
            : await getDataFromApi(isFirst: true, lastId: 0);
        last = data['last'];
        //categories
        newItems = data['stories'];

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
      newItems = data['stories'];
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
    super.initState();
    getDataFromApi(isFirst: true);

    lastID = -1;
    _pageController = PageController();
    _pagingController.addPageRequestListener((page) {
      fetchNewPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'المنشورات',
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
              height: 5.h,
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
              child: PagedListView<int, StoryModel>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<StoryModel>(
                    noItemsFoundIndicatorBuilder: ((context) => Center(
                            child: Text(
                          "لايوجد منشورات",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ))),
                    firstPageErrorIndicatorBuilder: ((context) => Center(
                            child: Text(
                          "حدث خطأ",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ))),
                    newPageErrorIndicatorBuilder: (context) => Center(
                            child: Text(
                          "حدث خطأ",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )),
                    itemBuilder: (context, item, index) {
                      return Column(
                        children: [
                          if (!widget.isBrowsing!)
                            Container(
                              width: 150.w,
                              margin: EdgeInsets.only(bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5.r)),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (c) => AlertDialog(
                                                content: deleteWidget(
                                                    storyId: item.id)));
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Get.to(EditStory(
                                          storyId: item.id,
                                          description: item.description,
                                        ));
                                      },
                                      icon: Icon(
                                        Icons.mode_edit_outlined,
                                        color: Colors.blue,
                                      )),
                                ],
                              ),
                            ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            height: 60.h,
                            width: double.infinity,
                            child: Text(
                              item.description!,
                              softWrap: false,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          item.videoLink == ""
                              ? SizedBox(
                                  height: 140.h,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: item.imagesLinks!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.all(5.r),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: item.imagesLinks![index],
                                            imageBuilder: (context,
                                                    imageProvider) =>
                                                Container(
                                                    height: 90.h,
                                                    width: 90.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(ImageViewer(
                                                            imageProvider:
                                                                imageProvider));
                                                      },
                                                    )),
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 90.h,
                                              width: 90.h,
                                              margin: const EdgeInsets.all(10),
                                              child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: Colors.blue,
                                                strokeWidth: 1,
                                              )),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        );
                                      }),
                                )
                              : Column(
                                  children: [
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: VideoStory(
                                        videoUrl: item.videoLink,
                                      ),
                                    ),
                                    SizedBox(height: 7.h),
                                  ],
                                ),
                          SizedBox(height: 12.h),
                          Divider(
                              color: primaryColor,
                              thickness: 4.sp,
                              height: 2.sp)
                        ],
                      );
                    }),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Container deleteWidget({int? storyId}) {
    return Container(
      height: 100.h,
      width: 50.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.sp)),
      child: Obx(() {
        if (storyController.isDeletePost.value) {
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
              "هل تريد حذف منشورك؟",
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
                      await storyController.deletePost(storyId: storyId);
                      setState(() {
                        lastID = -1;
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
                      Navigator.pop(context);
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
