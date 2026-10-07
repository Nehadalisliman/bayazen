import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';

class GlobalLoading extends StatelessWidget {
  const GlobalLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: primaryColor,
      ),
    );
  }
}
