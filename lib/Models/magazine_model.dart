// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MagazineResponseModel magazineFromJson(String str) => MagazineResponseModel.fromJson(json.decode(str));

String magazineToJson(MagazineResponseModel data) => json.encode(data.toJson());

class MagazineResponseModel {
  MagazineResponseModel({
     this.result,
     this.message,
     this.userId,
     this.magazine,
  });

  bool? result;
  String? message;
  int? userId;
  String? magazine;

  factory MagazineResponseModel.fromJson(Map<String, dynamic> json) => MagazineResponseModel(
    result: json["result"],
    message: json["message"],
    userId: json["user_id"]==null?0: int.tryParse( json["user_id"].toString()),
    magazine: json["magazine"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "user_id": userId,
    "magazine": magazine,
  };
}
