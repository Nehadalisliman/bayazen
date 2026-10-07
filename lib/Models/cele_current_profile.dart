// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class CelebrityResponseModel {
  CelebrityResponseModel({
    this.result,
    this.id,
    this.message,
    this.image,
    this.name,
    this.bio,
    this.eduction,
    this.experience,
    this.skills,
    this.personal_vid,
    this.interests,
    this.specialization,
  });
  int? id;
  String? bio;
  String? image;
  bool? result;
  String? message;
  String? specialization;
  String? name;
  String? personal_vid;

  List<dynamic>? eduction;
  List<dynamic>? experience;
  List<String>? skills;
  List<dynamic>? interests;

  CelebrityResponseModel copyWith(
          {bool? result,
          String? message,
          String? name,
          String? bio,
          int? id,
          String? image,
          String? specialization,
          String? personal_vid,
          List<dynamic>? education,
          List<dynamic>? experience,
          List<String>? skills,
          List<dynamic>? interests,
          List<dynamic>? programs}) =>
      CelebrityResponseModel(
        result: result ?? this.result,
        personal_vid: personal_vid ?? this.personal_vid,
        name: name ?? this.name,
        id: id ?? this.id,
        specialization: specialization ?? this.specialization,
        message: message ?? this.message,
        image: message ?? this.image,
        eduction: education ?? this.eduction,
        experience: experience ?? this.experience,
        skills: skills ?? this.skills,
        interests: interests ?? this.interests,
        bio: bio ?? this.bio,
      );

  factory CelebrityResponseModel.fromRawJson(String str) =>
      CelebrityResponseModel.fromJson(json.decode(str));

//  String toRawJson() => json.encode(toJson());

  factory CelebrityResponseModel.fromJson(Map<String, dynamic> json) =>
      CelebrityResponseModel(
        id: json["id"] ?? -1,
        result: json["result"] ?? false,
        personal_vid: json["personal_vid"] ?? "",
        message: json["message"] ?? "",
        specialization: json["specialization"] ?? "",
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        bio: json["bio"] ?? "",
        eduction: json["education"] == null
            ? []
            : List<dynamic>.from(json["education"].map((x) => x)),
        experience: json["experience"] == null
            ? []
            : List<dynamic>.from(json["experience"].map((x) => x)),
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"].map((x) => x)),
        interests: json["interests"] == null
            ? []
            : List<dynamic>.from(json["interests"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
        "name": name == null ? null : name,
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "specialization": specialization == null ? null : specialization,
        "personal_vid": personal_vid == null ? null : personal_vid,
        "bio": bio == null ? null : bio,
        "eduction": eduction == null
            ? null
            : List<dynamic>.from(eduction!.map((x) => x)),
        "experience": experience == null ? [] : experience,
        "skills":
            skills == null ? null : List<dynamic>.from(skills!.map((x) => x)),
        "interests": interests == null
            ? null
            : List<dynamic>.from(interests!.map((x) => x)),
      };

// Map<String, dynamic> toJson() => {
//   "result": result == null ? null : result,
//   "message": message == null ? null : message,
//   "data": data == null ? null : data.toJson(),
//   "user_id": userId == null ? null : userId,
// };
}

// class Data {
//   Data({
//     this.id,
//     this.fullName,
//     this.image,
//     this.spec,
//     this.personalVid,
//     this.bio,
//
//   });
//
//   int id;
//   String fullName;
//   String image;
//   String spec;
//   String personalVid;
//   String bio;
//
//
//   Data copyWith({
//     int id,
//     String fullname,
//     String image,
//     String spec,
//     String personalVid,
//     String bio,
//     List<String> education,
//     List<String> experience,
//     List<String> skills,
//     List<String> interests,
//   }) =>
//       Data(
//         id: id ?? this.id,
//         fullName: fullname ?? this.fullName,
//         image: image ?? this.image,
//         spec: spec ?? this.spec,
//         personalVid: personalVid ?? this.personalVid,
//         bio: bio ?? this.bio,
//
//       );
//
//   factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"] == null ? null : json["id"],
//         fullName: json["fullname"] == null ? null : json["fullname"],
//         image: json["image"] == null ? null : json["image"],
//         spec: json["spec"] == null ? null : json["spec"],
//         personalVid: json["personal_vid"] == null ? null : json["personal_vid"],
//         bio: json["bio"] == null ? null : json["bio"],
//         education: json["education"] == null
//             ? null
//             : List<String>.from(json["education"].map((x) => x)),
//         experience: json["experience"] == null
//             ? null
//             : List<String>.from(json["experience"].map((x) => x)),
//         skills: json["skills"] == null
//             ? null
//             : List<String>.from(json["skills"].map((x) => x)),
//         interests: json["interests"] == null
//             ? null
//             : List<String>.from(json["interests"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "fullname": fullName == null ? null : fullName,
//         "image": image == null ? null : image,
//         "spec": spec == null ? null : spec,
//         "personal_vid": personalVid == null ? null : personalVid,
//         "bio": bio == null ? null : bio,
//         "education": education == null
//             ? null
//             : List<dynamic>.from(education.map((x) => x)),
//         "experience": experience == null
//             ? null
//             : List<dynamic>.from(experience.map((x) => x)),
//         "skills":
//             skills == null ? null : List<dynamic>.from(skills.map((x) => x)),
//         "interests": interests == null
//             ? null
//             : List<dynamic>.from(interests.map((x) => x)),
//       };
// }
