import 'package:e_learning/Controllers/course_ware_controller.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class CreateCategory extends StatelessWidget {
  TextEditingController category_title = TextEditingController();
  TextEditingController category_description = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('رفع تصنيف',
            style: TextStyle(
                color: accentColor,
                fontFamily: 'Janna LT Regular',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: accentColor,
            )),
        backgroundColor: buttonTextColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            hintText: 'اسم التصنيف ',
            controller: category_title,
          ),
          CustomTextField(
            hintText: 'نبذه عن التصنيف',
            controller: category_description,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            // ignore: deprecated_member_use
            child: TextButton(
                onPressed: () {
                  _formKey.currentState?.save();
                  CourseWareController().createCategory(
                      title: category_title.text,
                      description: category_description.text);
                  category_title.clear();
                  category_description.clear();
                  // Flushbar(message: 'Uploading  Success',duration: Duration(seconds: 10),).show(context);
                },
                child: const Text(
                  'حفظ التصنيف',
                  style: TextStyle(
                      color: buttonTextColor,
                      fontFamily: 'Janna LT Regular',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
          ),
        ],
      ),
    );
  }
}
