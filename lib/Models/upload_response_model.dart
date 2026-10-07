// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UploadResponseModel uploadFromJson(String str) => UploadResponseModel.fromJson(json.decode(str));

String uploadToJson(UploadResponseModel data) => json.encode(data.toJson());

class UploadResponseModel {
  UploadResponseModel({
     this.result,
     this.message,
     this.videoUrl,
     this.userId,
  });

  bool? result;
  String? message;
  String? videoUrl;
  String? userId;

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) => UploadResponseModel(
    result: json["result"],
    message: json["message"],
    videoUrl: json["video_url"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "video_url": videoUrl,
    "user_id": userId,
  };
}
