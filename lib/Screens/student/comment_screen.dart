import 'package:e_learning/Controllers/comment_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Screens/student/nested_comment.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CommentScreen extends StatefulWidget {
  final int video_ID;
  CommentScreen({required this.video_ID});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();

  late CommentController controller;
  _getComments() async {
    await controller.getComments(video_id: widget.video_ID);
  }

  @override
  void initState() {
    controller = Get.put(CommentController());
    _getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.video_ID);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('التعليقات',
              style: TextStyle(
                  color: accentColor,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold)),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: accentColor,
            ),
          ),
          backgroundColor: buttonTextColor,
        ),
        body: Obx(() {
          if (controller.isGetComment.value) {
            return GlobalLoading();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: controller.isPostComment.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GlobalLoading(),
                      )
                    : TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                            hintText: 'اضف تعليق',
                            prefixIcon: InkWell(
                                onTap: () async {
                                  await controller.postComment(
                                      videoId: widget.video_ID,
                                      comment: commentController.text);
                                  commentController.clear();
                                  await controller.getComments(
                                      video_id: widget.video_ID);
                                },
                                child: Icon(
                                  Icons.send,
                                  color: primaryColor,
                                ))),
                      ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getComments(video_id: widget.video_ID);
                    return Future.value(true);
                  },
                  child: ListView.builder(
                      itemCount:
                          controller.commentResponseModel?.comments?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Get.to(NestedCommentScreen(
                                  commentId: controller.commentResponseModel!
                                      .comments![index].id,
                                  videoId: widget.video_ID,
                                ));
                               
                              },
                              /*  leading: GestureDetector(
                                      onTap: () async {
                                        print("Comment Clicked");
                                      },
                                      child: Container(
                                        height: 50.0,
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(50))),
                                        child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                                "${snapshot.data.comments[index].pic}")),
                                      ),
                                    ),*/
                              title: Text(
                                "${controller.commentResponseModel?.comments?[index].fullname}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  '${controller.commentResponseModel?.comments?[index].comment}'),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ],
          );
        }));
  }
}
