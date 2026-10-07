import 'package:flutter/material.dart';

const primaryColor = Color(0xFF19456b);
const accentColor = Color(0xFF1687a7);
const backgroundColor = Color(0xFFd3e0ea);
const background = Color(0xFF5EF15C);

class AppColor {
 static const containerColor=Colors.lightBlue;
  /// color for light theme
  static const primaryColor = Color(0xFF5867DD);
  static const accentColor = Color(0xFFC6CBFA);
  static const backgroundColor = Color(0xFFF9F9F9);
  static const whiteColor = Colors.white;
  static const shadowBackgroundColor = Color(0xFFCFD2F6);
  static const cardBackgroundColor = Color(0xFFFFFFFF);
  static const grayBorderColor = Color(0xFFE0E0E0);
  static const grayColor = Color(0xFF747272);

  /// color for  text
  static const titleTextColor = Color(0xFF333945);
  static const subTitleTextColor = Color(0xFF90a4ae);
  static const descTextColor = Color(0xFF90a4ae);
  static const secondaryTextColor = Color(0xFFE5E5E5);
  static const hintColor = Color(0xFFB1B1B1);
  static const appBarColor = Color(0xFF333945);

  /// color for  text
  static const titleTextDarkColor = Color(0xFFf6f5f5);
  static const homeTabColor = Color(0xFF363853);
  static const descTextDarkColor = Color(0xFF90a4ae);
  static const secondaryTextDarkColor = Color(0xFFE5E5E5);
  static const hintDarkColor = Color(0xFFB1B1B1);
  static const hintBlackColor = Color(0xFF111111);

  static const imageBackgroundColor1 = Color(0xFFF0F0F7);
  static const imageBackgroundColor2 = Color(0xFFF0F0F7);
  static const imageBackgroundColor3 = Color(0xFFFDE8D4);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

final mainHintColor = HexColor('F7EEEE');
final toastWarningColor = HexColor('FF1937');
