// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CelRegisterResponse celeFromJson(String str) => CelRegisterResponse.fromJson(json.decode(str));

String celeToJson(CelRegisterResponse data) => json.encode(data.toJson());

class CelRegisterResponse {
  CelRegisterResponse({
    this.result,
    this.userType,
    this.message,
    this.userId,
  });

  bool? result;
  String? userType;
  String? message;
  int? userId;

  CelRegisterResponse copyWith({
    bool? result,
    String? userType,
    String? message,
    int? userId,
  }) =>
      CelRegisterResponse(
        result: result ?? this.result,
        userType: userType ?? this.userType,
        message: message ?? this.message,
        userId: userId ?? this.userId,
      );

  factory CelRegisterResponse.fromJson(Map<String, dynamic> json) => CelRegisterResponse(
    result: json["result"],
    userType: json["user_type"],
    message: json["message"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "user_type": userType,
    "message": message,
    "user_id": userId,
  };
}
