// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);
//
// import 'dart:convert';
//
// HomeResponseModel homeFromJson(String str) => HomeResponseModel.fromJson(json.decode(str));
//
// String homeToJson(HomeResponseModel data) => json.encode(data.toJson());
//
// class HomeResponseModel {
//   HomeResponseModel({
//     this.result,
//     this.message,
//     this.userId,
//     this.firstName,
//     this.image,
//     this.accessToken,
//     this.reviews,
//   });
//
//   bool result;
//   String message;
//   int userId;
//   String firstName;
//   String image;
//   String accessToken;
//   Map<String, Review> reviews;
//
//   HomeResponseModel copyWith({
//     bool result,
//     String message,
//     int userId,
//     String firstName,
//     String image,
//     String accessToken,
//     Map<String, Review> reviews,
//   }) =>
//       HomeResponseModel(
//         result: result ?? this.result,
//         message: message ?? this.message,
//         userId: userId ?? this.userId,
//         firstName: firstName ?? this.firstName,
//         image: image ?? this.image,
//         accessToken: accessToken ?? this.accessToken,
//         reviews: reviews ?? this.reviews,
//       );
//
//   factory HomeResponseModel.fromJson(Map<String, dynamic> json) => HomeResponseModel(
//     result: json["result"] == null ? null : json["result"],
//     message: json["message"] == null ? null : json["message"],
//     userId: json["user_id"] == null ? null : json["user_id"],
//     firstName: json["first_name"] == null ? null : json["first_name"],
//     image: json["image"] == null ? null : json["image"],
//     accessToken: json["access_token"] == null ? null : json["access_token"],
//     reviews: json["reviews"] == null ? null : Map.from(json["reviews"]).map((k, v) => MapEntry<String, Review>(k, Review.fromJson(v))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "result": result == null ? null : result,
//     "message": message == null ? null : message,
//     "user_id": userId == null ? null : userId,
//     "first_name": firstName == null ? null : firstName,
//     "image": image == null ? null : image,
//     "access_token": accessToken == null ? null : accessToken,
//     "reviews": reviews == null ? null : Map.from(reviews).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
//   };
// }
//
// class Review {
//   Review({
//     this.id,
//     this.name,
//     this.rating,
//     this.comment,
//   });
//
//   int id;
//   String name;
//   int rating;
//   String comment;
//
//   Review copyWith({
//     int id,
//     String name,
//     int rating,
//     String comment,
//   }) =>
//       Review(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         rating: rating ?? this.rating,
//         comment: comment ?? this.comment,
//       );
//
//   factory Review.fromJson(Map<String, dynamic> json) => Review(
//     id: json["id"] == null ? null : json["id"],
//     name: json["name"] == null ? null : json["name"],
//     rating: json["rating"] == null ? null : json["rating"],
//     comment: json["comment"] == null ? null : json["comment"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "name": name == null ? null : name,
//     "rating": rating == null ? null : rating,
//     "comment": comment == null ? null : comment,
//   };
// }
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

HomeResponseModel homeFromJson(String str) => HomeResponseModel.fromJson(json.decode(str));

String homeToJson(HomeResponseModel data) => json.encode(data.toJson());

class HomeResponseModel {
  HomeResponseModel({
    this.result,
    this.message,
    this.userId,
    this.firstName,
    this.image,
    this.accessToken,
    this.topFive,
  });

  bool? result;
  String? message;
  int? userId;
  String? firstName;
  String? image;
  String? accessToken;
  List<Review>? topFive;

  HomeResponseModel copyWith({
    bool? result,
    String? message,
    int? userId,
    String? firstName,
    String? image,
    String? accessToken,
    List<Review>? topFive,
  }) =>
      HomeResponseModel(
        result: result ?? this.result,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        image: image ?? this.image,
        accessToken: accessToken ?? this.accessToken,
        topFive: topFive ?? this.topFive,
      );

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) => HomeResponseModel(
    result: json["result"],
    message: json["message"],
    userId: json["user_id"],
    firstName: json["first_name"],
    image: json["image"],
    accessToken: json["access_token"],
    topFive: json["top_five"] == null ? null : List<Review>.from(json["top_five"].map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "user_id": userId,
    "first_name": firstName,
    "image": image,
    "access_token": accessToken,
    "top_five": topFive == null ? null : List<dynamic>.from(topFive!.map((x) => x.toJson())),
  };
}

class Review {
  Review ({
    this.id,
    this.name,
    this.rating,
  });

  int? id;
  String? name;
  int? rating;

  Review copyWith({
    int? id,
    String? name,
    int? rating,
  }) =>
      Review(
        id: id ?? this.id,
        name: name ?? this.name,
        rating: rating ?? this.rating,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    name: json["name"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "rating": rating,
  };
}
