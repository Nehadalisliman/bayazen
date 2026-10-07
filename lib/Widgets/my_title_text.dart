import 'package:e_learning/Widgets/app_color.dart';
import 'package:flutter/material.dart';

//__________________________ title text_______________________________________
// ignore: must_be_immutable
class MyTitleText extends StatelessWidget {
  final String? text;
  final String? trText;
  final Color color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? isOverflow;
  final int? lines;

  const MyTitleText(
      {Key? key,
        this.text,
        this.trText,
        this.color = AppColor.hintBlackColor,
        this.fontSize,
        this.textAlign,
        this.fontWeight,
        this.isOverflow,
        this.lines})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text ?? trText!,
    textAlign: textAlign ?? TextAlign.start,
    textScaleFactor: 1.0,
    overflow: isOverflow ?? TextOverflow.ellipsis,
    maxLines: lines ?? 1,
    style: TextStyle(
      color: color ?? AppColor.titleTextColor,
      fontSize: fontSize ?? 12.0,
      fontFamily: "montserrat",
      fontWeight: fontWeight ?? FontWeight.bold,
    ),
  );
}

//__________________________ subtitle text_______________________________________
// ignore: must_be_immutable
class MySubTitleText extends StatelessWidget {
  final String? text;
  final String? trText;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? isOverflow;
  final Function? onTap;
  final int? lines;

  const MySubTitleText(
      {Key? key,
        this.text,
        this.trText,
        this.color,
        this.fontSize,
        this.textAlign,
        this.fontWeight,
        this.isOverflow,
        this.lines,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text ?? trText ?? '',
    textAlign: textAlign ?? TextAlign.start,
    textScaleFactor: 1.0,
    overflow: isOverflow ?? TextOverflow.ellipsis,
    maxLines: text != null
        ? text!.isNotEmpty
        ? text!.length
        : 1
        : lines ?? 1,
    style: TextStyle(
      color: color ?? AppColor.titleTextColor,
      fontSize: fontSize ?? 12.0,
      fontFamily: "montserrat",
      fontWeight: fontWeight ?? FontWeight.w600,
    ),
  );
}

class MySubTitlePassword extends StatelessWidget {
  final String? text;
  final String? trText;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? isOverflow;
  final Function? onTap;
  final int? lines;

  const MySubTitlePassword(
      {Key? key,
        this.text,
        this.trText,
        this.color,
        this.fontSize,
        this.textAlign,
        this.fontWeight,
        this.isOverflow,
        this.lines,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap as void Function()?,
    child: Text(
      text ?? trText ?? '',
      textAlign: textAlign ?? TextAlign.start,
      textScaleFactor: 1.0,
      overflow: isOverflow ?? TextOverflow.ellipsis,
      maxLines: text != null
          ? text!.isNotEmpty
          ? text!.length
          : 1
          : lines ?? 1,
      style: TextStyle(
        color: color ?? AppColor.titleTextColor,
        fontSize: fontSize ?? 12.0,
        fontFamily: "montserrat",
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    ),
  );
}
//__________________________ desc text_______________________________________
// ignore: must_be_immutable
class MyDescText extends StatelessWidget {
  final String? text;
  final String? trText;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final int? lines;

  const MyDescText(
      {Key? key,
        this.text,
        this.trText,
        this.color,
        this.fontSize,
        this.textAlign,
        this.fontWeight,
        this.textOverflow,
        this.lines})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text ?? trText!,
    textAlign: textAlign ?? TextAlign.justify,
    softWrap: true,
    // textScaleFactor: 1.0,
    overflow: textOverflow ?? TextOverflow.ellipsis,
    maxLines: lines ?? 1,
    style: TextStyle(
        color: color ?? AppColor.titleTextColor,
        fontSize: fontSize ?? 9.0,
        fontFamily: "montserrat",
        fontWeight: fontWeight ?? FontWeight.w400),
  );
}

//__________________________ AppBar text_______________________________________
class MyAppBarText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? isOverflow;

  const MyAppBarText(
      {Key? key,
        this.text,
        this.color,
        this.fontSize,
        this.textAlign,
        this.fontWeight,
        this.isOverflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text!,
    textAlign: textAlign ?? TextAlign.start,
    textScaleFactor: 1.0,
    overflow: isOverflow ?? TextOverflow.ellipsis,
    style: TextStyle(
      color: color ?? AppColor.appBarColor,
      fontSize: fontSize ?? 10.0,
      fontFamily: "montserrat",
      fontWeight: fontWeight ?? FontWeight.w600,
    ),
  );
}
class SubTitleText extends StatelessWidget {
  final String? text;
  final String? trText;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? isOverflow;
  final Function? onTap;
  final int? lines;

  const SubTitleText(
      {Key? key,
        this.text,
        this.trText,
        this.color,
        this.fontSize,
        this.textAlign,
        this.fontWeight,
        this.isOverflow,
        this.lines,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text ?? trText ?? '',
    textAlign: textAlign ?? TextAlign.start,
    textScaleFactor: 1.0,
    overflow: isOverflow ?? TextOverflow.ellipsis,
    maxLines: text != null
        ? text!.isNotEmpty
        ? text!.length
        : 1
        : lines ?? 1,
    style: TextStyle(
      color: color ?? AppColor.titleTextColor,
      fontSize: fontSize ?? 17.0,
      fontFamily: "montserrat",
      fontWeight: fontWeight ?? FontWeight.w600,
    ),
  );
}