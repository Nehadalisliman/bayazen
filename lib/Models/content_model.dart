// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ContentResponseModel welcomeFromJson(String str) => ContentResponseModel.fromJson(json.decode(str));

String welcomeToJson(ContentResponseModel data) => json.encode(data.toJson());

class ContentResponseModel {
  ContentResponseModel({
    this.result,
    this.message,
    this.userId,
    this.videos,
  });

  bool? result;
  String? message;
  int? userId;
  List<String>? videos;

  ContentResponseModel copyWith({
    bool? result,
    String? message,
    int? userId,
    List<String>? videos,
  }) =>
      ContentResponseModel(
        result: result ?? this.result,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        videos: videos ?? this.videos,
      );

  factory ContentResponseModel.fromJson(Map<String, dynamic> json) => ContentResponseModel(
    result: json["result"],
    message: json["message"],
    userId: json["user_id"],
    videos: List<String>.from(json["videos"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "user_id": userId,
    "videos": List<dynamic>.from(videos!.map((x) => x)),
  };
}
