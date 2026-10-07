import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Screens/celebrity/celebrity_profile.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CelePage extends StatefulWidget {
  @override
  State<CelePage> createState() => _CelePageState();
}

class _CelePageState extends State<CelePage> {
  @override
  void initState() {
    controller.getCele();
    // TODO: implement initState
    super.initState();
  }

  // final NetworkUtil _networkUtil = NetworkUtil();
  final ContentController controller = Get.put(ContentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(' المؤثرين',
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
        body: Obx(() {
          if (controller.isCelLoading.value) {
            print("loading");
            return GlobalLoading();
          }

          if (controller.celeResponseModel == null) {
            print("NODATceleA");
            return Container(
              padding: EdgeInsets.all(20.sp),
              child: Center(
                  child: Text(
                "لايوجد اشخاص في الوقت الحالي",
                style: TextStyle(color: Colors.black, fontSize: 20.sp),
              )),
            );
          }

          if (controller.celeResponseModel!.data == [] ||
              controller.celeResponseModel!.data!.isEmpty ||
              controller.celeResponseModel!.data == null) {
            print("NODATA");
            return Container(
              padding: EdgeInsets.all(20.sp),
              child: Center(
                  child: Text(
                "لايوجد اشخاص في الوقت الحالي",
                style: TextStyle(color: Colors.black, fontSize: 20.sp),
              )),
            );
          }
          if (controller.celeResponseModel!.data != []) {
            print("Data");
            print(controller.celeResponseModel!.data.toString());
            return ListView.builder(
                itemCount: controller.celeResponseModel!.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(CelebrityProfile());
                      },
                      child: Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                      '${controller.celeResponseModel!.data![index].fullname}',
                                      style: TextStyle(
                                          color: accentColor,
                                          fontFamily: 'Janna LT Regular',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      '${controller.celeResponseModel!.data![index].spec}',
                                      style: TextStyle(
                                          color: Color(0xFF42BFEF),
                                          fontFamily: 'Janna LT Regular',
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    '${controller.celeResponseModel!.data![index].image}'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }

          return Container(
            height: 300,
          );
        }));
  }
}
