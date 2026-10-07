// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LibraryVideoResponse welcomeFromJson(String str) =>
    LibraryVideoResponse.fromJson(json.decode(str));

String welcomeToJson(LibraryVideoResponse data) => json.encode(data.toJson());

class LibraryVideoResponse {
  LibraryVideoResponse({
    this.result,
    this.message,
    this.userId,
    this.libraryId,
    this.videos,
  });

  bool? result;
  String? message;
  int? userId;
  int? libraryId;
  List<Video>? videos;

  LibraryVideoResponse copyWith({
    bool? result,
    String? message,
    int? userId,
    int? libraryId,
    List<Video>? videos,
  }) =>
      LibraryVideoResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        libraryId: libraryId ?? this.libraryId,
        videos: videos ?? this.videos,
      );

  factory LibraryVideoResponse.fromJson(Map<String, dynamic> json) =>
      LibraryVideoResponse(
        result: json["result"],
        message: json["message"],
        userId: json["user_id"],
        libraryId: json["library_id"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "user_id": userId,
        "library_id": libraryId,
        "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
      };
}

class Video {
  Video({
    this.id,
    this.title,
    this.video,
    this.description,
    this.createdAt,
  });

  int? id;
  String? title;
  String? video;
  String? description;
  DateTime? createdAt;

  Video copyWith({
    int? id,
    String? title,
    String? video,
    String? description,
    DateTime? createdAt,
  }) =>
      Video(
        id: id ?? this.id,
        title: title ?? this.title,
        video: video ?? this.video,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        video: json["link"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": video,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
      };
}
