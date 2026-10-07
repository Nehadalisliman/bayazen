import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeConfig {
  double screenWidth = Get.context!.orientation == Orientation.portrait
      ? Get.mediaQuery.size.width
      : Get.mediaQuery.size.height;

  double screenHeight = Get.context!.orientation == Orientation.portrait
      ? Get.mediaQuery.size.height
      : Get.mediaQuery.size.width;

  double infinityHeight() => double.infinity;

  double infinityWidth() => double.infinity;

  double blockSizeHorizontal() => screenWidth / 100;

  double blockSizeVertical() => screenHeight / 100;

  double _safeAreaHorizontal() =>
      Get.mediaQuery.padding.left + Get.mediaQuery.padding.right;

  double _safeAreaVertical() =>
      Get.mediaQuery.padding.top + Get.mediaQuery.padding.bottom;

  double safeBlockHorizontal() =>
      (screenWidth -
          (Get.context!.orientation == Orientation.portrait
              ? _safeAreaHorizontal()
              : _safeAreaVertical())) /
      100;

  double safeBlockVertical() =>
      (screenHeight -
          (Get.context!.orientation == Orientation.portrait
              ? _safeAreaVertical()
              : _safeAreaHorizontal())) /
      100;

  double fontSize10() => safeBlockHorizontal() * 1.0;

  double fontSize11() => safeBlockHorizontal() * 1.1;

  double fontSize12() => safeBlockHorizontal() * 1.2;

  double fontSize13() => safeBlockHorizontal() * 1.3;

  double fontSize14() => safeBlockHorizontal() * 1.4;

  double fontSize15() => safeBlockHorizontal() * 1.5;

  double fontSize16() => safeBlockHorizontal() * 1.6;

  double fontSize17() => safeBlockHorizontal() * 1.7;

  double fontSize18() => safeBlockHorizontal() * 1.8;

  double fontSize19() => safeBlockHorizontal() * 1.9;

  double fontSize20() => safeBlockHorizontal() * 2.0;

  double fontSize21() => safeBlockHorizontal() * 2.1;

  double fontSize22() => safeBlockHorizontal() * 2.2;

  double fontSize23() => safeBlockHorizontal() * 2.3;

  double fontSize24() => safeBlockHorizontal() * 2.4;

  double fontSize25() => safeBlockHorizontal() * 2.5;

  double fontSize26() => safeBlockHorizontal() * 2.6;

  double fontSize27() => safeBlockHorizontal() * 2.7;

  double fontSize28() => safeBlockHorizontal() * 2.8;

  double fontSize29() => safeBlockHorizontal() * 2.9;

  double fontSize30() => safeBlockHorizontal() * 3.0;

  double fontSize31() => safeBlockHorizontal() * 3.1;

  double fontSize32() => safeBlockHorizontal() * 3.2;

  double fontSize33() => safeBlockHorizontal() * 3.3;

  double fontSize34() => safeBlockHorizontal() * 3.4;

  double fontSize35() => safeBlockHorizontal() * 3.5;

  double fontSize36() => safeBlockHorizontal() * 3.6;

  double fontSize37() => safeBlockHorizontal() * 3.7;

  double fontSize38() => safeBlockHorizontal() * 3.8;

  double fontSize39() => safeBlockHorizontal() * 3.9;

  double fontSize40() => safeBlockHorizontal() * 4.0;

  double fontSize41() => safeBlockHorizontal() * 4.1;

  double fontSize42() => safeBlockHorizontal() * 4.2;

  double fontSize43() => safeBlockHorizontal() * 4.3;

  double fontSize44() => safeBlockHorizontal() * 4.4;

  double fontSize45() => safeBlockHorizontal() * 4.5;

  double fontSize46() => safeBlockHorizontal() * 4.6;

  double fontSize47() => safeBlockHorizontal() * 4.7;

  double fontSize48() => safeBlockHorizontal() * 4.8;

  double fontSize49() => safeBlockHorizontal() * 4.9;

  double fontSize50() => safeBlockHorizontal() * 5.0;

  double fontSize51() => safeBlockHorizontal() * 5.1;

  double fontSize52() => safeBlockHorizontal() * 5.2;

  double fontSize53() => safeBlockHorizontal() * 5.3;

  double fontSize54() => safeBlockHorizontal() * 5.4;

  double fontSize55() => safeBlockHorizontal() * 5.5;

  double fontSize56() => safeBlockHorizontal() * 5.6;

  double fontSize57() => safeBlockHorizontal() * 5.7;

  double fontSize58() => safeBlockHorizontal() * 5.8;

  double fontSize59() => safeBlockHorizontal() * 5.9;
}
