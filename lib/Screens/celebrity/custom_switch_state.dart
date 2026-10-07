import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_learning/Screens/celebrity/category/category_details.dart';
import 'package:e_learning/Screens/celebrity/chapters/chapter_detail.dart';
import 'package:e_learning/Screens/celebrity/edit_category_screen.dart';
import 'package:e_learning/Screens/celebrity/pagination/model/library_item.dart';
import 'package:e_learning/Widgets/custom_text.dart';
import 'package:e_learning/core/helpers/dio_helper.dart';
import 'package:e_learning/core/helpers/helper_dio.dart';
import 'package:e_learning/core/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'library/edit_library.dart';
import 'pagination/model/category_item.dart';

const double borderRadius = 25.0;

class CustomSwitchState extends StatefulWidget {
  //     ? isBrowsing
  final bool isBrowsing;
  final int? celebId;
  //  ?End
  final String? programTitle;
  final int? programID;

  const CustomSwitchState(
      {Key? key,
      this.programTitle,
      this.programID,
      this.isBrowsing = false,
      this.celebId})
      : super(key: key);
  @override
  _CustomSwitchStateState createState() => _CustomSwitchStateState();
}

class _CustomSwitchStateState extends State<CustomSwitchState>
    with SingleTickerProviderStateMixin {
  PageController? _pageController;
  int activePageIndex = 0;

  int? lastID;

  final PagingController<int, CategoryItem> _pagingCategoryController =
      PagingController(firstPageKey: 0);

  final PagingController<int, LibraryItem> _pagingLibraryController =
      PagingController(firstPageKey: 0);
  int x = 0;
  // todo  ========= Pagination Categories =============
  getDataCategoriesFromApi({int? lastId, required bool isFirst}) async {
    x++;
    log("Start res");
    var query = isFirst
        ? {
            "programId": widget.programID,
            "onlySome": true,
          }
        : {"programId": widget.programID, "onlySome": true, "lastId": lastId};

    var response = await HelperDio.get(
      endpoint: 'categories',
      data: query,
      token: userToken,
    );

    log("response category ${response.data}");

    if (response.statusCode == 200) {
      log("response 200");
      List<dynamic>? data = response.data['categories'];
      bool? last = response.data['Last'];
      List<CategoryItem> categoryItems = [];
      if (data != []) {
        data!.forEach((element) {
          categoryItems.add(CategoryItem.fromJson(element));
        });
      }
      log("categoryItems$categoryItems");
      var returnData = {'last': last, 'categories': categoryItems};
      return returnData;
    } else {
      log("response error");
      // server error
      return Future.error("Server Error !");
    }
  }

  getDataCategoriesFromApiBrwosing({int? lastId, required bool isFirst}) async {
    x++;
    log("Getting Categories Brwosing  $x");
    // var dio = Dio();
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // String? token = await prefs.getString('token');
    // log("token $token");

    log("Start res");
    var query = isFirst
        ? {
            "programId": widget.programID,
            "celebId": widget.celebId,
            "onlySome": true
          }
        : {
            "programId": widget.programID,
            "celebId": widget.celebId,
            "onlySome": true,
            "lastId": lastId
          };

    var response = await HelperDio.get(
      endpoint: 'browse/categories',
      data: query,
      token: userToken,
    );

    log("response ${response.data}");

    if (response.statusCode == 200) {
      log("response 200");
      List<dynamic>? data = response.data['categories'];
      bool? last = response.data['Last'];
      List<CategoryItem> categoryItems = [];
      if (data != []) {
        data!.forEach((element) {
          categoryItems.add(CategoryItem.fromJson(element));
        });
      }
      log("categoryItems$categoryItems");
      var returnData = {'last': last, 'categories': categoryItems};
      return returnData;
    } else {
      log("response error");
      // server error
      return Future.error("Server Error !");
    }
  }

  // ? ==== Categories =====
  Future<void> fetchNewPageCategories() async {
    bool? last;
    List<CategoryItem>? newItems = [];
    var data;

    try {
      if (lastID == -1) {
        log("First");
        data = widget.isBrowsing
            ? await getDataCategoriesFromApiBrwosing(isFirst: true, lastId: 0)
            : await getDataCategoriesFromApi(isFirst: true, lastId: 0);
        last = data['last'];
        //categories
        newItems = data['categories'];

        if (last!) {
          _pagingCategoryController.appendLastPage(newItems!);
          return;
        }
        lastID = newItems!.last.id;
        log("lastID $lastID");
        _pagingCategoryController.appendPage(newItems, lastID);
        return;
      }
      data = widget.isBrowsing
          ? await getDataCategoriesFromApiBrwosing(
              isFirst: false, lastId: lastID)
          : await getDataCategoriesFromApi(isFirst: false, lastId: lastID);
      last = data['last'];
      //categories
      newItems = data['categories'];
      if (last!) {
        log("is Last Page");

        lastID = newItems!.last.id;
        log("lastID  $lastID");
        _pagingCategoryController.appendLastPage(newItems);
        return;
      } else {
        log("is Not Last Page");

        lastID = newItems!.last.id;
        log("lastID  $lastID");
        _pagingCategoryController.appendPage(newItems, lastID);
        return;
      }
    } catch (e) {
      _pagingCategoryController.error = e;
    }
  }

  // todo  ============ Pagination Libraries ==========

  getDataLibrariesFromApiBrowsing({int? lastId, required bool isFirst}) async {
    x++;
    print("Getting Brwosing Lib  $x");
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = await prefs.getString('token');
    log("token $token");

    log("Start res");
    var query = isFirst
        ? {
            "programId": widget.programID,
            "celebId": widget.celebId,
            "onlySome": true
          }
        : {
            "programId": widget.programID,
            "celebId": widget.celebId,
            "onlySome": true,
            "lastId": lastId
          };
    var response = await HelperDio.get(
      endpoint: 'browse/libraries',
      data: query,
      token: userToken,
    );
    log("response $response");

    if (response.statusCode == 200) {
      log("response 200");
      List<dynamic>? data = response.data['libraries'];
      bool? last = response.data['Last'];
      List<LibraryItem> categoryItems = [];
      if (data != []) {
        data!.forEach((element) {
          categoryItems.add(LibraryItem.fromJson(element));
        });
      }
      log("libraries From Browsing $categoryItems");
      var returnData = {'last': last, 'categories': categoryItems};
      return returnData;
    } else {
      log("response error");
      // server error
      return Future.error("Server Error !");
    }
  }

  getDataLibrariesFromApi({int? lastId, required bool isFirst}) async {
    x++;
    log("Getting More Data  $x");
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = await prefs.getString('token');
    log("token $token");

    log("Start res");
    var query = isFirst
        ? {"programId": widget.programID, "onlySome": true}
        : {"programId": widget.programID, "onlySome": true, "lastId": lastId};
    var response = await HelperDio.get(
      endpoint: 'libraries',
      data: query,
      token: userToken,
    );

    log("response $response");

    if (response.statusCode == 200) {
      log("response 200");
      List<dynamic>? data = response.data['libraries'];
      bool? last = response.data['Last'];
      List<LibraryItem> categoryItems = [];
      if (data != []) {
        data!.forEach((element) {
          categoryItems.add(LibraryItem.fromJson(element));
        });
      }
      log("categoryItems$categoryItems");
      var returnData = {'last': last, 'categories': categoryItems};
      return returnData;
    } else {
      log("response error");
      // server error
      return Future.error("Server Error !");
    }
  }

  // ? ===== lib  ====
  Future<void> fetchNewPageLibraries() async {
    bool? last;
    List<LibraryItem>? newItems = [];
    var data;

    try {
      if (lastID == -1) {
        log("First");
        data = widget.isBrowsing
            ? await getDataLibrariesFromApiBrowsing(isFirst: true, lastId: 0)
            : await getDataLibrariesFromApi(isFirst: true, lastId: 0);
        last = data['last'];
        //categories
        newItems = data['categories'];

        if (last!) {
          _pagingLibraryController.appendLastPage(newItems!);
          return;
        }
        lastID = newItems!.last.id;
        log("lastID $lastID");
        _pagingLibraryController.appendPage(newItems, lastID);
        return;
      }
      data = widget.isBrowsing
          ? await getDataLibrariesFromApiBrowsing(
              isFirst: false, lastId: lastID)
          : await getDataLibrariesFromApi(isFirst: false, lastId: lastID);
      last = data['last'];
      //categories
      newItems = data['categories'];
      if (last!) {
        log("is Last Page");

        lastID = newItems!.last.id;
        log("lastID  $lastID");
        _pagingLibraryController.appendLastPage(newItems);
        return;
      } else {
        log("is Not Last Page");

        lastID = newItems!.last.id;
        log("lastID  $lastID");
        _pagingLibraryController.appendPage(newItems, lastID);
        return;
      }
    } catch (e) {
      _pagingLibraryController.error = e;
    }
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getDataCategoriesFromApi(isFirst: false);
    lastID = -1;
    _pageController = PageController();
    _pagingCategoryController.addPageRequestListener((page) {
      fetchNewPageCategories();
    });
    _pagingLibraryController.addPageRequestListener((page) {
      fetchNewPageLibraries();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.programTitle);
    print(widget.celebId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.programTitle!,
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: _menuBar(context),
          ),
          Expanded(
            flex: 2,
            child: PageView(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (int i) {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  activePageIndex = i;
                });
              },
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  // todo ==== Pagination  Category ====
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () {
                        setState(() {
                          lastID = -1;
                          _pagingCategoryController.refresh();
                        });
                      },
                    ),
                    child: PagedListView<int, CategoryItem>(
                      pagingController: _pagingCategoryController,
                      builderDelegate: PagedChildBuilderDelegate<CategoryItem>(
                          noItemsFoundIndicatorBuilder: ((context) => Center(
                                  child: Text(
                                "لايوجد مناهج تعليميه",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ))),
                          itemBuilder: (context, item, index) {
                            print(item.id);
                            return Column(
                              children: [
                                cardCategory(item.title!, item.id),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  // todo ==== Pagination  Category ====
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () {
                        setState(() {
                          lastID = -1;
                          _pagingLibraryController.refresh();
                        });
                      },
                    ),
                    child: PagedListView<int, LibraryItem>(
                      pagingController: _pagingLibraryController,
                      builderDelegate: PagedChildBuilderDelegate<LibraryItem>(
                          noItemsFoundIndicatorBuilder: ((context) => Center(
                                  child: Text(
                                "لايوجد مكتبات ",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ))),
                          itemBuilder: (context, item, index) {
                            return Column(
                              children: [
                                cardLibrary(
                                  id: item.id,
                                  name: item.title!,
                                  description: item.description!,
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardCategory(String name, int? id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            customText(
                text: name, fontSize: 12.sp, fontWeight: FontWeight.w600),
            Spacer(),
            if (!widget.isBrowsing)
              IconButton(
                  onPressed: () {
                    Get.to(EditCategory(
                      title: name,
                      categoryId: id,
                    ));
                  },
                  icon: Icon(
                    Icons.mode_edit_outlined,
                    color: Colors.blue,
                  )),
            IconButton(
                onPressed: () {
                  Get.to(CategoryDetails(
                    isBrowsing: widget.isBrowsing,
                    celebId: widget.celebId,
                    programTitle: widget.programTitle,
                    categoryTitle: name,
                    categoryId: id,
                  ));
                },
                icon: Icon(
                  Icons.visibility,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  Widget cardLibrary(
      {int? id, required String name, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160.w,
                  child: customText(
                      text: name,
                      fontSize: 12.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
              ],
            ),
            Spacer(),
            if (!widget.isBrowsing)
              IconButton(
                  onPressed: () {
                    // todo Edit Library
                    Get.to(EditLibrary(
                      title: name,
                      libraryId: id,
                      description: description,
                    ));
                  },
                  icon: Icon(
                    Icons.mode_edit_outlined,
                    color: Colors.blue,
                  )),
            IconButton(
                onPressed: () {
                  // todo Chapter
                  Get.to(ChapterDetails(
                    isBrowsing: widget.isBrowsing,
                    celebId: widget.celebId,
                    programTitle: widget.programTitle,
                    libraryName: name,
                    programId: widget.programID,
                  ));
                },
                icon: Icon(
                  Icons.visibility,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  Widget _menuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0.h,
      decoration: const BoxDecoration(
        color: Color(0XFFE0E0E0),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              onTap: _onPlaceBidButtonPress,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: (activePageIndex == 0)
                    ? const BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius)),
                      )
                    : null,
                child: Text(
                  "المناهج التعليميه",
                  style: (activePageIndex == 0)
                      ? TextStyle(color: Colors.white, fontSize: 12.sp)
                      : TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              onTap: _onBuyNowButtonPress,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: (activePageIndex == 1)
                    ? const BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius)),
                      )
                    : null,
                child: Text(
                  "سلسلهً المكتبات",
                  style: (activePageIndex == 1)
                      ? TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp)
                      : TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPlaceBidButtonPress() {
    _pageController!.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onBuyNowButtonPress() {
    _pageController!.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
