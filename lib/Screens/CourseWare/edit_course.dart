import 'package:e_learning/Controllers/course_ware_controller.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditCourseOld extends StatefulWidget {
  String? title;
  final int? id;
  final int? course_id;

  EditCourseOld({Key? key, this.title, this.id, this.course_id})
      : super(key: key);

  @override
  _EditCourseState createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourseOld> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            children: [
              CustomTextField(
                initialValue: widget.title,
                onChanged: (value) {
                  widget.title = value;
                },
                // initialValue: snapshot.data.bio,
                //controller: bio,
              ),
              TextButton(
                onPressed: () {
                  CourseWareController().editCourse(
                      category_id: widget.id,
                      course_id: widget.course_id,
                      title: widget.title);
                },
                child: Text('حفظ'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
