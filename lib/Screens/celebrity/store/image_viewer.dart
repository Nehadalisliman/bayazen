import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final dynamic imageProvider;
  const ImageViewer({Key? key, this.imageProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: PhotoView(imageProvider: imageProvider)),
    );
  }
}
