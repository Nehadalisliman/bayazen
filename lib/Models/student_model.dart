// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

StudentProfileResponse studentProfileFromJson(String str) => StudentProfileResponse.fromJson(json.decode(str));

String studentProfileToJson(StudentProfileResponse data) => json.encode(data.toJson());

class StudentProfileResponse {
  StudentProfileResponse({
    this.result,
    this.message,
    this.name,
    this.image,
    this.specialization,
    this.bio,
    this.following,
    this.followedBy,
  });

  bool? result;
  String? message;
  String? name;
  String? image;
  dynamic specialization;
  dynamic bio;
  int? following;
  int? followedBy;

  StudentProfileResponse copyWith({
    bool? result,
    String? message,
    String? name,
    String? image,
    dynamic specialization,
    dynamic bio,
    int? following,
    int? followedBy,
  }) =>
      StudentProfileResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        name: name ?? this.name,
        image: image ?? this.image,
        specialization: specialization ?? this.specialization,
        bio: bio ?? this.bio,
        following: following ?? this.following,
        followedBy: followedBy ?? this.followedBy,
      );

  factory StudentProfileResponse.fromJson(Map<String, dynamic> json) => StudentProfileResponse(
    result: json["result"],
    message: json["message"],
    name: json["name"],
    image: json["image"],
    specialization: json["specialization"],
    bio: json["bio"],
    following: json["following"],
    followedBy: json["followed_by"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "name": name,
    "image": image,
    "specialization": specialization,
    "bio": bio,
    "following": following,
    "followed_by": followedBy,
  };
}
