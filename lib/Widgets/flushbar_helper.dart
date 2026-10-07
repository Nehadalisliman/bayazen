import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashHelper {
  static final FlashHelper _instance = FlashHelper._internal();

  factory FlashHelper() => _instance;

  FlashHelper._internal();

  TextStyle _titleStyle([Color? color]) {
    var theme = Theme.of(Get.context!);
    return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.titleLarge)!
        .copyWith(color: color);
  }

  TextStyle _contentStyle([Color? color]) {
    var theme = Theme.of(Get.context!);
    return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyMedium)!
        .copyWith(color: color);
  }

  Future<T?> infoBar<T>({
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) =>
      showFlash<T>(
        context: Get.context!,
        duration: duration,
        builder: (context, controller) => Flash(
          controller: controller,
          // horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          // backgroundColor: Colors.black87,
          // alignment: Alignment.bottomCenter,
          child: FlashBar(
            controller: controller,
            title: title == null
                ? null
                : Text(title, style: _titleStyle(Colors.white)),
            content: Text(message, style: _contentStyle(Colors.white)),
            icon: Icon(Icons.info_outline, color: Colors.green[300]),
            indicatorColor: Colors.green[300],
          ),
        ),
      );

  Future<T?>? successBar<T>({
    String? title,
    required String? message,
    Duration duration = const Duration(seconds: 3),
  }) {
    try {
      return showFlash<T>(
        context: Get.context!,
        duration: duration,
        builder: (context, controller) => Flash(
          controller: controller,
          position: FlashPosition.top,

          // horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            backgroundColor: Colors.green,
            position: FlashPosition.top,
            margin: EdgeInsets.all(12),
            controller: controller,
            title: title == null
                ? null
                : Text(title, style: _titleStyle(Colors.white)),
            content: Text(message!, style: _contentStyle(Colors.white)),
            icon: Icon(Icons.check_circle, color: Colors.blue[300]),
            indicatorColor: Colors.blue[300],
          ),
        ),
      );
    } catch (_) {
      return null;
    }
  }

  Future<T?> errorBar<T>({
    String? title,
    required String? message,
    Duration duration = const Duration(seconds: 5),
  }) =>
      showFlash<T>(
        context: Get.context!,
        duration: duration,
        builder: (context, controller) => StatefulBuilder(
            builder: (context, setState) => Flash(
                  controller: controller,
                  // horizontalDismissDirection:
                  //     HorizontalDismissDirection.horizontal,
                  // backgroundColor: Colors.black87,
                  // alignment: Alignment.bottomCenter,
                  child: FlashBar(
                    controller: controller,
                    title: title == null
                        ? null
                        : Text(title, style: _titleStyle(Colors.white)),
                    content: Text(message!, style: _contentStyle(Colors.white)),
                    icon: Icon(Icons.warning, color: Colors.red[300]),
                    indicatorColor: Colors.red[300],
                  ),
                )),
      );
}
