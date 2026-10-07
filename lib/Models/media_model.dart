// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MediaResponseModel mediaFromJson(String str) => MediaResponseModel.fromJson(json.decode(str));

String mediaToJson(MediaResponseModel data) => json.encode(data.toJson());

class MediaResponseModel {
  MediaResponseModel({
    this.result,
    this.message,
    this.userId,
    this.personalVid,
    this.image,
  });

  bool? result;
  String? message;
  String? userId;
  String? personalVid;
  String? image;

  MediaResponseModel copyWith({
    bool? result,
    String? message,
    String? userId,
    String? personalVid,
    String? image,
  }) =>
      MediaResponseModel(
        result: result ?? this.result,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        personalVid: personalVid ?? this.personalVid,
        image: image ?? this.image,
      );

  factory MediaResponseModel.fromJson(Map<String, dynamic> json) => MediaResponseModel(
    result: json["result"],
    message: json["message"],
    userId: json["user_id"],
    personalVid: json["personal_vid"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "user_id": userId,
    "personal_vid": personalVid,
    "image": image,
  };
}
