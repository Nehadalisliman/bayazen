import 'package:e_learning/Screens/CourseWare/create_category_screen.dart';
import 'package:e_learning/Screens/old_work/upload_magazin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class AddContentScreen extends StatefulWidget {
  const AddContentScreen({Key? key}) : super(key: key);

  @override
  _AddContentScreenState createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('انشاء',
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
      body: Center(
        child: Column(
          children: [
            // Container(
            //   margin: const EdgeInsets.only(top: 20),
            //     child: TextButton(onPressed: (){Get.to(const Upload());}, child: const Text('رفع فيديو',style: TextStyle(color: accentColor,fontFamily: 'Janna LT Regular',fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,))),
            Container(
                width: 200,
                margin: const EdgeInsets.only(top: 20),
                decoration:
                    BoxDecoration(border: Border.all(color: primaryColor)),
                child: TextButton(
                    onPressed: () {
                      Get.to(const UploadMagazine());
                    },
                    child: const Text(
                      'رفع علي المجله',
                      style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Janna LT Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ))),
            Container(
                width: 200,
                margin: const EdgeInsets.only(top: 20),
                decoration:
                    BoxDecoration(border: Border.all(color: primaryColor)),
                child: TextButton(
                    onPressed: () {
                      Get.to(CreateCategory());
                    },
                    child: const Text(
                      '  رفع تصنيف',
                      style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Janna LT Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )))
          ],
        ),
      ),
    );
  }
}
