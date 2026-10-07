import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../../../../../constants.dart';

class VideoSection extends StatefulWidget {
  final String? video;
  final bool isBrowing;
  const VideoSection({Key? key, required this.isBrowing, required this.video})
      : super(key: key);

  @override
  State<VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    if (widget.video != null && widget.video!.isNotEmpty && widget.video != "") {
      try {
        videoPlayerController = VideoPlayerController.network(widget.video!);
        videoPlayerController!.addListener(() {
          if (mounted) setState(() {});
        });
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          aspectRatio: 16 / 9,
          autoPlay: false,
          looping: false,
          showControls: true,
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
      } catch (e) {
        print("Video init error: $e");
      }
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chewieController == null || videoPlayerController == null) {
      return Container(
        height: 180.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const Center(
          child: Text(
            "لا يوجد فيديو متاح حالياً",
            style: TextStyle(fontFamily: 'Janna LT Regular', color: Colors.grey),
          ),
        ),
      );
    }
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Chewie(
        controller: chewieController!,
      ),
    );
  }
}
