// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LibraryResponse welcomeFromJson(String str) =>
    LibraryResponse.fromJson(json.decode(str));

String welcomeToJson(LibraryResponse data) => json.encode(data.toJson());

class LibraryResponse {
  LibraryResponse({
    this.result,
    this.libraries,
  });

  bool? result;
  List<LibraryModel2>? libraries;
  int? userId;

  factory LibraryResponse.fromJson(Map<String, dynamic> json) =>
      LibraryResponse(
        result: json["result"] == null ? null : json["result"],
        libraries: json["libraries"] == null
            ? null
            : List<LibraryModel2>.from(
                json["libraries"].map((x) => LibraryModel2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "libraries": libraries == null
            ? null
            : List<dynamic>.from(libraries!.map((x) => x.toJson())),
      };
}

class LibraryModel2 {
  LibraryModel2({
    this.id,
    this.title,
    this.description,
  });

  int? id;
  String? title;
  String? description;

  factory LibraryModel2.fromJson(Map<String, dynamic> json) => LibraryModel2(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
      };
}
