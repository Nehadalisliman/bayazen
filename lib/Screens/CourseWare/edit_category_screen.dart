import 'package:e_learning/Controllers/course_ware_controller.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EditCategory extends StatefulWidget {
  String? title;
  String? description;
  int? id;

   EditCategory({Key? key, this.title, this.description, this.id}) : super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(' تعديل التصنيف',style: TextStyle(color: accentColor,fontFamily: 'Janna LT Regular',fontSize: 18,fontWeight: FontWeight.bold)),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back,color: accentColor,)),
        backgroundColor: buttonTextColor,
      ),
      body: Column(
        children: [
         CustomTextField(
           initialValue: widget.title,
           onChanged: (value){
             widget.title=value;
           },
         ),
          CustomTextField(
            initialValue: widget.description,
            onChanged: (value){
              widget.description=value;
            },
          ),
          Container(
            margin:const EdgeInsets.only(top: 15),
            // ignore: deprecated_member_use
            child:TextButton(

                onPressed:(){
                  CourseWareController().editCategory(title: widget.title,description: widget.description,category_id: widget.id);
                  // Flushbar(message: 'Uploading  Success',duration: Duration(seconds: 10),).show(context);

                }, child: const Text(' تعديل التصنيف',style: TextStyle(color: buttonTextColor,fontFamily: 'Janna LT Regular',fontWeight: FontWeight.bold,fontSize: 18),)),
          ),
        ],
      ),
    );
  }
}
