import 'package:e_learning/Controllers/comment_controller.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NestedCommentScreen extends StatefulWidget {
  final int? commentId;
  final dynamic videoId;
  NestedCommentScreen({this.commentId, this.videoId});

  @override
  State<NestedCommentScreen> createState() => _NestedCommentScreenState();
}

class _NestedCommentScreenState extends State<NestedCommentScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();

  CommentController controller = Get.put(CommentController());

  @override
  void initState() {
    controller.getNestedComments(commentId: widget.commentId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('ردود التعليقات',
              style: TextStyle(
                  color: accentColor,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 15.sp,
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
          if (controller.isGetNestedComment.value) {
            return GlobalLoading();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Obx(() {
                  if (controller.isPostNestedComment.value) {
                    return Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: GlobalLoading());
                  }
                  return TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                        hintText: 'اضف تعليق',
                        prefixIcon: InkWell(
                            onTap: () async {
                              await controller.postNestedComment(
                                  commentId: widget.commentId,
                                  videoId: widget.videoId,
                                  comment: commentController.text);
                              commentController.clear();
                              await controller.getNestedComments(
                                  commentId: widget.commentId!);
                            },
                            child: Icon(
                              Icons.send,
                              color: primaryColor,
                            ))),
                  );
                }),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getNestedComments(
                        commentId: widget.commentId!);
                    return Future.value(true);
                  },
                  child: ListView.builder(
                      itemCount: controller
                          .nestedCommentResponseModel!.comments!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
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
                                "${controller.nestedCommentResponseModel!.comments![index].fullname}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  '${controller.nestedCommentResponseModel!.comments![index].comment}'),
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
