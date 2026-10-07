// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LibraryResponseModel welcomeFromJson(String str) =>
    LibraryResponseModel.fromJson(json.decode(str));

String welcomeToJson(LibraryResponseModel data) => json.encode(data.toJson());

class LibraryResponseModel {
  LibraryResponseModel({
    this.result,
    this.message,
    this.userId,
    this.mainVideo,
    this.libraries,
  });

  bool? result;
  String? message;
  int? userId;
  MainVideo? mainVideo;
  List<LibraryModel>? libraries;

  factory LibraryResponseModel.fromJson(Map<String, dynamic> json) =>
      LibraryResponseModel(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
        userId: json["user_id"] == null ? null : json["user_id"],
        mainVideo: json["main_video"] == null
            ? null
            : MainVideo.fromJson(json["main_video"]),
        libraries: json["libraries"] == null
            ? null
            : List<LibraryModel>.from(
                json["libraries"].map((x) => LibraryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
        "user_id": userId == null ? null : userId,
        "main_video": mainVideo == null ? null : mainVideo!.toJson(),
        "libraries": libraries == null
            ? null
            : List<dynamic>.from(libraries!.map((x) => x.toJson())),
      };
}

class LibraryModel {
  LibraryModel({this.id, this.title, this.description});

  int? id;
  String? title;
  String? description;

  factory LibraryModel.fromJson(Map<String, dynamic> json) => LibraryModel(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description
      };
}

class MainVideo {
  MainVideo({
    this.title,
    this.video,
    this.description,
    this.createdAt,
  });

  String? title;
  String? video;
  String? description;
  DateTime? createdAt;

  factory MainVideo.fromJson(Map<String, dynamic> json) => MainVideo(
        title: json["title"] == null ? null : json["title"],
        video: json["video"] == null ? null : json["video"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "video": video == null ? null : video,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
      };
}
