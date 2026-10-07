// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

FileResponseModel fileFromJson(String str) => FileResponseModel.fromJson(json.decode(str));

String fileToJson(FileResponseModel data) => json.encode(data.toJson());

class FileResponseModel {
  FileResponseModel({
     this.result,
     this.message,
     this.fileUrl,
     this.userId,
  });

  bool? result;
  String? message;
  String? fileUrl;
  String? userId;

  factory FileResponseModel.fromJson(Map<String, dynamic> json) => FileResponseModel(
    result: json["result"],
    message: json["message"],
    fileUrl: json["file_url"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "file_url": fileUrl,
    "user_id": userId,
  };
}
