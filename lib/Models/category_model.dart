// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CategoryResponseModel welcomeFromJson(String str) =>
    CategoryResponseModel.fromJson(json.decode(str));

String welcomeToJson(CategoryResponseModel data) => json.encode(data.toJson());

class CategoryResponseModel {
  CategoryResponseModel({
    this.result,
    this.message,
    this.categories,
    this.userId,
  });

  bool? result;
  String? message;
  List<Category>? categories;
  int? userId;

  CategoryResponseModel copyWith({
    bool? result,
    String? message,
    List<Category>? categories,
    int? userId,
  }) =>
      CategoryResponseModel(
        result: result ?? this.result,
        message: message ?? this.message,
        categories: categories ?? this.categories,
        userId: userId ?? this.userId,
      );

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryResponseModel(
        result: json["result"] ?? false,
        message: json["message"] ?? "",
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        userId: json["user_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "user_id": userId,
      };
}

class Category {
  Category({
    this.id,
    this.celebId,
    this.title,
    this.description,
  });

  int? id;
  String? celebId;
  String? title;
  String? description;

  Category copyWith({
    int? id,
    String? celebId,
    String? title,
    String? description,
  }) =>
      Category(
        id: id ?? this.id,
        celebId: celebId ?? this.celebId,
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] ?? 0,
        celebId: json["celeb_id"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "celeb_id": celebId,
        "title": title,
        "description": description,
      };
}
