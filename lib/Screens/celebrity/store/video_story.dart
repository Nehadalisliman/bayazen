import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:e_learning/Widgets/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../constants.dart';

class VideoStory extends StatefulWidget {
  final String? videoUrl;
  VideoStory({Key? key, this.videoUrl}) : super(key: key);

  @override
  State<VideoStory> createState() => _VideoStoryState();
}

class _VideoStoryState extends State<VideoStory> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool hasError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();

    /* videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) => setState(() {}));*/
    videoPlayerController = VideoPlayerController.network(widget.videoUrl!);

    videoPlayerController.addListener(() {
      log('here');
      if (videoPlayerController.value.isBuffering) {
        log('buffering');
      } else if (videoPlayerController.value.hasError) {
        log('error');
        log(videoPlayerController.value.errorDescription!);

        log("hasError $hasError");
        if (videoPlayerController.value.errorDescription ==
            "Video player had error com.google.android.exoplayer2.ExoPlaybackException: Source error") {
          setState(() {
            hasError = true;
            errorMessage = 'خطأ بالانترنت لا يمكن تشغيل الفيديو';
          });
          FlashHelper().errorBar(message: errorMessage);
        } else {
          setState(() {
            hasError = true;
            errorMessage = 'لا يمكن تشغيل الفيديو';
          });

          FlashHelper().errorBar(message: errorMessage);
        }
      } else if (videoPlayerController.value.position ==
          videoPlayerController.value.duration) {
        log('completed');
      }
    });

    chewieController = ChewieController(
      errorBuilder: (context, _errorMessage) {
        log("errorMessage ${_errorMessage}");
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.red, fontSize: 18.sp),
          ),
        );
      },

      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,

      autoPlay: false,
      looping: false,
      // Try playing around with some of these other options:
      showControls: true,
      // showOptions: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: primaryColor,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey[200]!,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Chewie(
        controller: chewieController,
      ),
    );
  }
}
