// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import 'package:video_player/video_player.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: VideoPicker(),
//     );
//   }
// }

// class VideoPicker extends StatefulWidget {
//   @override
//   _VideoPickerState createState() => _VideoPickerState();
// }

// class _VideoPickerState extends State<VideoPicker> {
//   late File _video;

//   Future _pickVideo() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _video = File(pickedFile.path);
//       } else {
//         print('No video selected.');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Picker'),
//       ),
//       body: Center(
//         child: _video == null
//             ? Text('No video selected.')
//             : VideoPlayerWidget(videoFile: _video),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _pickVideo,
//         tooltip: 'Pick Video',
//         child: Icon(Icons.video_library),
//       ),
//     );
//   }
// }

// class VideoPlayerWidget extends StatefulWidget {
//   final File videoFile;

//   const VideoPlayerWidget({Key? key, required this.videoFile})
//       : super(key: key);

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(widget.videoFile);
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.setLooping(true); // Optional: Set looping
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initializeVideoPlayerFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
