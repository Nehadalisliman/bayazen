// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProfileResponseModel welcomeFromJson(String str) => ProfileResponseModel.fromJson(json.decode(str));

String welcomeToJson(ProfileResponseModel data) => json.encode(data.toJson());

class ProfileResponseModel {
  ProfileResponseModel({
    this.result,
    this.message,
    this.name,
    this.image,
    this.specialization,
    this.bio,
    this.skills,
    this.eduction,
    this.experience,
    this.personalVid,
    this.interests,
  });

  bool? result;
  String? message;
  String? name;
  String? image;
  String? specialization;
  String? bio;
  List<String>? skills;
  List<String>? eduction;
  List<String>? experience;
  dynamic personalVid;
  List<String>? interests;

  ProfileResponseModel copyWith({
    bool? result,
    String? message,
    String? name,
    String? image,
    String? specialization,
    String? bio,
    List<String>? skills,
    List<String>? eduction,
    List<String>? experience,
    dynamic personalVid,
    List<String>? interests,
  }) =>
      ProfileResponseModel(
        result: result ?? this.result,
        message: message ?? this.message,
        name: name ?? this.name,
        image: image ?? this.image,
        specialization: specialization ?? this.specialization,
        bio: bio ?? this.bio,
        skills: skills ?? this.skills,
        eduction: eduction ?? this.eduction,
        experience: experience ?? this.experience,
        personalVid: personalVid ?? this.personalVid,
        interests: interests ?? this.interests,
      );

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
    result: json["result"],
    message: json["message"],
    name: json["name"],
    image: json["image"],
    specialization: json["specialization"],
    bio: json["bio"],
    skills:json["skills"] ==null?null:List<String>.from(json["skills"].map((x) => x)),
    eduction:json["eduction"]==null?null: List<String>.from(json["eduction"].map((x) => x)),
    experience:json["experience"]==null?null: List<String>.from(json["experience"].map((x) => x)),
    personalVid: json["personal_vid"],
    interests:json["interests"]==null?null: List<String>.from(json["interests"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "name": name,
    "image": image,
    "specialization": specialization,
    "bio": bio,
    "skills": List<dynamic>.from(skills!.map((x) => x)),
    "eduction": List<dynamic>.from(eduction!.map((x) => x)),
    "experience": List<dynamic>.from(experience!.map((x) => x)),
    "personal_vid": personalVid,
    "interests": List<dynamic>.from(interests!.map((x) => x)),
  };
}
