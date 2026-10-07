// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CommentResponseModel welcomeFromJson(String str) =>
    CommentResponseModel.fromJson(json.decode(str));

String welcomeToJson(CommentResponseModel data) => json.encode(data.toJson());

class CommentResponseModel {
  CommentResponseModel({
    this.result,
    this.message,
    this.comments,
  });

  bool? result;
  String? message;

  List<Comment>? comments;

  CommentResponseModel copyWith({
    bool? result,
    String? message,
    int? userId,
    String? name,
    String? pic,
    List<Comment>? comments,
  }) =>
      CommentResponseModel(
        result: result ?? this.result,
        message: message ?? this.message,
        comments: comments ?? this.comments,
      );

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) =>
      CommentResponseModel(
        result: json["result"] ?? false,
        message: json["message"] ?? '',
        comments: json["comments"] != null
            ? List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Comment {
  Comment(
      {this.id,
      this.video_id,
      this.fullname,
      this.user_type,
      this.comment,
      this.children,
      this.date});

  final int? id;
  final int? video_id;
  final String? fullname;
  final String? user_type;
  final String? comment;
  final bool? children;
  final String? date;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] ?? 0,
        video_id: json["video_id"] ?? '',
        fullname: json["fullname"] ?? '',
        user_type: json["user_type"] ?? '',
        comment: json["comment"] ?? '',
        children: json["children"] ?? false,
        date: json["Date"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_id": video_id,
        "fullname": fullname,
        "user_type": user_type,
        "comment": comment,
        "children": children,
        "Date": date,
      };
}
