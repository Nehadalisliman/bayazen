// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginTeacherResponse loginFromJson(String str) =>
    LoginTeacherResponse.fromJson(json.decode(str));

String loginToJson(LoginTeacherResponse data) => json.encode(data.toJson());

class LoginTeacherResponse {
  LoginTeacherResponse({
    this.result,
    this.message,
    this.userId,
    this.phone,
    this.email,
    this.name,
    this.accessToken,
  });

  bool? result;
  String? message;
  int? userId;
  String? phone;
  String? email;
  String? name;
  String? accessToken;

  factory LoginTeacherResponse.fromJson(Map<String, dynamic> json) =>
      LoginTeacherResponse(
        result: json["result"],
        message: json["message"],
        userId: json["user_id"],
        phone: json["phone"],
        email: json["email"],
        name: json["name"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "user_id": userId,
        "phone": phone,
        "email": email,
        "name": name,
        "access_token": accessToken,
      };
}
