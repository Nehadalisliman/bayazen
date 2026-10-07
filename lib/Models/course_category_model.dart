// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CourseCategoryModel welcomeFromJson(String str) => CourseCategoryModel.fromJson(json.decode(str));

String welcomeToJson(CourseCategoryModel data) => json.encode(data.toJson());

class CourseCategoryModel {
  CourseCategoryModel({
    this.result,
    this.message,
    this.courses,
    this.isLast,
    this.userId,
  });

  bool? result;
  String? message;
  List<Course>? courses;
  bool? isLast;
  int? userId;

  CourseCategoryModel copyWith({
    bool? result,
    String? message,
    List<Course>? courses,
    bool? isLast,
    int? userId,
  }) =>
      CourseCategoryModel(
        result: result ?? this.result,
        message: message ?? this.message,
        courses: courses ?? this.courses,
        isLast: isLast ?? this.isLast,
        userId: userId ?? this.userId,
      );

  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) => CourseCategoryModel(
    result: json["result"],
    message: json["message"],
    courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    isLast: json["is_last"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "courses": List<dynamic>.from(courses!.map((x) => x.toJson())),
    "is_last": isLast,
    "user_id": userId,
  };
}

class Course {
  Course({
    this.id,
    this.celebId,
    this.coursecateId,
    this.title,
    this.course,
    this.size,
    this.extension,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? celebId;
  String? coursecateId;
  String? title;
  String? course;
  String? size;
  String? extension;
  DateTime? createdAt;
  DateTime? updatedAt;

  Course copyWith({
    int? id,
    String? celebId,
    String? coursecateId,
    String? title,
    String? course,
    String? size,
    String? extension,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Course(
        id: id ?? this.id,
        celebId: celebId ?? this.celebId,
        coursecateId: coursecateId ?? this.coursecateId,
        title: title ?? this.title,
        course: course ?? this.course,
        size: size ?? this.size,
        extension: extension ?? this.extension,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    celebId: json["celeb_id"],
    coursecateId: json["coursecate_id"],
    title: json["title"],
    course: json["course"],
    size: json["size"],
    extension: json["extension"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "celeb_id": celebId,
    "coursecate_id": coursecateId,
    "title": title,
    "course": course,
    "size": size,
    "extension": extension,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
