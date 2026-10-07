// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Models/library_video_model.dart';
import 'package:e_learning/Screens/old_work/upload.dart';
import 'package:e_learning/Screens/student/comment_screen.dart';
import 'package:e_learning/Widgets/vedio_item.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/core/helpers/size_config.dart';

// ignore: must_be_immutable
class VideoLibrary extends StatelessWidget {
  SizeConfig sizeConfig = SizeConfig();
  final int chapterId;
  final String nameChapter;
  final String nameLibarary;
  final int programId;

  bool? isSelected;
  VideoLibrary({
    Key? key,
    required this.chapterId,
    required this.nameChapter,
    required this.nameLibarary,
    required this.programId,
    this.isSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(chapterId);
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
        actions: [
          IconButton(
            onPressed: () {
              Get.to(Upload(
                nameChapter: nameChapter,
                programId: programId,
                nameLibarary: nameLibarary,
                chapterId: chapterId,
              ));
            },
            icon: Icon(Icons.add),
          )
        ],
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
      body: FutureBuilder<LibraryVideoResponse>(
        future: CelebController().getVideosChapter(chapterId: chapterId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.videos!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoItems(
                            videoPlayerController:
                                VideoPlayerController.network(
                                    snapshot.data!.videos![index].video!),
                            looping: true,
                            autoplay: false,
                            width: sizeConfig.screenWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Text(
                              "${snapshot.data!.videos![index].title}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Janna LT Regular',
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.setInt(
                                "video_id", snapshot.data!.videos![index].id!);
                            Get.to(CommentScreen(
                                video_ID: snapshot.data!.videos![index].id!));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.comment),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Comments",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Janna LT Regular',
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
