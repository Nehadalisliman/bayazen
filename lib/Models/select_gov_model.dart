// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.result,
    this.message,
    this.userId,
    this.governorates,
  });

  bool? result;
  String? message;
  int? userId;
  List<String>? governorates;

  Welcome copyWith({
    bool? result,
    String? message,
    int? userId,
    List<String>? governorates,
  }) =>
      Welcome(
        result: result ?? this.result,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        governorates: governorates ?? this.governorates,
      );

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
    userId: json["user_id"] == null ? null : json["user_id"],
    governorates: json["governorates"] == null ? null : List<String>.from(json["governorates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
    "user_id": userId == null ? null : userId,
    "governorates": governorates == null ? null : List<dynamic>.from(governorates!.map((x) => x)),
  };
}
