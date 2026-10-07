import 'dart:math';

import 'package:flutter/material.dart';

const primaryColor=Color(0xFF43BEEE);
const accentColor=Color(0xFF010101);
const backgroundColor=Color(0xFFf0f0f0);
const textColor=Color(0xFFC7C7C7);
const buttonTextColor=Color(0xFFffffff);
const containerColor=Colors.lightBlue;
Color generateRandomColor1() {
  // Define all colors you want here
  const predefinedColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.white
  ];
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}




