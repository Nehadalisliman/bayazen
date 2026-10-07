import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
      {required this.title, required this.titleTextStyle, Key? key})
      : super(key: key);
  final String? title;
  final TextStyle titleTextStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      textDirection: TextDirection.rtl,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.right,
      style: titleTextStyle,
    );
  }
}
