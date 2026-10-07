import 'package:e_learning/Controllers/course_ware_controller.dart';
import 'package:e_learning/Models/course_category_model.dart';
import 'package:e_learning/Screens/CourseWare/edit_course.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class CourseScreen extends StatefulWidget {
  int? category_id;

  CourseScreen({Key? key, this.category_id}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("category_id${widget.category_id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(' الكورسات',
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
      body: FutureBuilder<CourseCategoryModel>(
        future: CourseWareController().getCoursescategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.courses!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: Card(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return SimpleDialog(
                                                      title: Text(
                                                          '     حذف الكورس'),
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            CourseWareController()
                                                                .deleteCourse(
                                                                    course_id: snapshot
                                                                        .data!
                                                                        .courses![
                                                                            index]
                                                                        .id);
                                                          },
                                                          child: Text(
                                                              'حذف الكورس'),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Icon(Icons.delete)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                            onTap: () {
                                              Get.offAll(EditCourseOld(
                                                course_id: snapshot
                                                    .data!.courses![index].id,
                                                id: widget.category_id,
                                                title: snapshot
                                                    .data!.courses![index].title,
                                              ));
                                            },
                                            child: Icon(Icons.edit)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        '${snapshot.data!.courses![index].title ?? ""}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'Janna LT Regular')),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        // ignore: deprecated_member_use
                                        await launch(snapshot
                                            .data!.courses![index].course!);
                                      },
                                      child: Text(
                                        '${snapshot.data!.courses![index].course}',
                                        style: TextStyle(color: primaryColor),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${snapshot.data!.courses![index].size}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${snapshot.data!.courses![index].extension}"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
