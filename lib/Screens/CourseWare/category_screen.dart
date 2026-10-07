import 'package:e_learning/Controllers/course_ware_controller.dart';
import 'package:e_learning/Models/category_model.dart';
import 'package:e_learning/Screens/CourseWare/course_screen.dart';
import 'package:e_learning/Screens/CourseWare/create_course_screen.dart';
import 'package:e_learning/Screens/CourseWare/edit_category_screen.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(' التصنيفات',
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
      body: FutureBuilder<CategoryResponseModel>(
        future: CourseWareController().getCategories().then((value) => value as CategoryResponseModel),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.categories!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () {
                                  Get.offAll(CreateCourse());
                                },
                                child: Icon(Icons.add)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () {
                                  Get.offAll(EditCategory(
                                    description: snapshot
                                        .data!.categories![index].description,
                                    title:
                                        snapshot.data!.categories![index].title,
                                    id: snapshot.data!.categories![index].id,
                                  ));
                                },
                                child: Icon(Icons.edit)),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            print(snapshot.data!.categories![index].id);
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.setInt("category_id",
                                snapshot.data!.categories![index].id!);
                            Get.to(CourseScreen(
                              category_id: snapshot.data!.categories![index].id,
                            ));
                          },
                          child: Card(
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                                height: 100,
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                  '${snapshot.data!.categories![index].title}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ))),
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
