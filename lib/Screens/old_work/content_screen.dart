// ignore_for_file: can_be_null_after_null_aware

import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Models/libraray_model.dart';
import 'package:e_learning/Screens/celebrity/edit_category_screen.dart';
import 'package:e_learning/Screens/old_work/video_library.dart';
import 'package:e_learning/Widgets/custom_nav_bar.dart';

import 'package:e_learning/Widgets/vedio_item.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/core/helpers/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  SizeConfig sizeConfig = SizeConfig();

  bool? isSelected;

  final ContentController controller = Get.put(ContentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('المحتوي',
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
          ),
        ),
        backgroundColor: buttonTextColor,
      ),
      body: FutureBuilder<LibraryResponseModel>(
        future: CelebController().getVedio(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoItems(
                        videoPlayerController: VideoPlayerController.network(
                            snapshot.data!.mainVideo!.video!),
                        looping: true,
                        autoplay: false,
                        width: sizeConfig.screenWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Libraries',
                          style: TextStyle(
                              color: accentColor,
                              fontFamily: 'Janna LT Regular',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .4,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.libraries!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Icon(Icons.edit),
                                      onTap: () {
                                        Get.offAll(EditCategory(
                                          description: snapshot.data!
                                              .libraries![index].description,
                                          title: snapshot
                                              .data!.libraries![index].title,
                                          id: snapshot
                                              .data!.libraries![index].id,
                                        ));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setInt("library_id",
                                        snapshot.data!.libraries![index].id!);
                                    print(snapshot.data!.libraries![index].id);
                                    // Get.to(VideoLibrary(chapterId: 1,));
                                  },
                                  child: Card(
                                    color: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: Center(
                                            child: Text(
                                          '${snapshot.data!.libraries![index].title}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // bottomNavigationBar: CustomNavigationBar(
      //   index: 3,
      // ),
    );
  }
}
