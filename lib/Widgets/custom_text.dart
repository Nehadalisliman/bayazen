import 'package:flutter/material.dart';

Widget customText({
  required String text,
  TextOverflow? overflow,
  TextDecoration? textDecoration,
    Color color=Colors.black,
  required double fontSize,
  required FontWeight fontWeight,
  int? maxLines,
}) =>
    Text(text,
        maxLines: maxLines,
        style: TextStyle(
          overflow: overflow,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: textDecoration,
        ));

