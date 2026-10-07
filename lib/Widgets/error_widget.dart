import 'package:e_learning/Widgets/my_title_text.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';


class HasError extends StatelessWidget {
  final String? errorText;

  const HasError({Key? key, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 100, bottom: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withOpacity(0.3),
                spreadRadius: 10,
                blurRadius: 70,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: const SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyTitleText(
            trText: errorText ?? "Please Check Connection!",
            fontSize: 16,
            textAlign: TextAlign.center,
            lines: errorText == null
                ? 1
                : errorText!.isEmpty
                ? 1
                : errorText!.length,
          ),
        )
      ],
    ),
  );
}
