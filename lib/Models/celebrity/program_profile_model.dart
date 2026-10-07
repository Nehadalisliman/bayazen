import 'package:flutter/cupertino.dart';

class ProgramModelProfile {
  bool? result;
  String? name;
  List<ProgramsData>? programs = [];

  ProgramModelProfile.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    name = json['fullname'];
    json['programs'].forEach((element) {
      programs?.add(ProgramsData.fromJson(element));
    });
  }
}

class ProgramsData {
  final int id;
  final String name;
  final String image;
  final String description;
  final String link;

  ProgramsData({
    required this.id,
    required this.name,
    required this.image,
    required this.link,
    required this.description,
  });

  factory ProgramsData.fromJson(Map<String, dynamic> json) => ProgramsData(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      link: json['link'] ?? "",
      description: json['description'] ?? "");
}
