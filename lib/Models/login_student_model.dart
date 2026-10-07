// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginStudentResponse studentFromJson(String str) => LoginStudentResponse.fromJson(json.decode(str));

String studentToJson(LoginStudentResponse data) => json.encode(data.toJson());

class LoginStudentResponse {
  LoginStudentResponse({
    this.result,
    this.userType,
    this.message,
    this.userId,
    this.phone,
    this.email,
    this.name,
    this.accessToken,
  });

  bool? result;
  String? userType;
  String? message;
  int? userId;
  String? phone;
  String? email;
  String? name;
  String? accessToken;

  LoginStudentResponse copyWith({
    bool? result,
    String? userType,
    String? message,
    int? userId,
    String? phone,
    String? email,
    String? name,
    String? accessToken,
  }) =>
      LoginStudentResponse(
        result: result ?? this.result,
        userType: userType ?? this.userType,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        name: name ?? this.name,
        accessToken: accessToken ?? this.accessToken,
      );

  factory LoginStudentResponse.fromJson(Map<String, dynamic> json) => LoginStudentResponse(
    result: json["result"],
    userType: json["user_type"],
    message: json["message"],
    userId: json["user_id"],
    phone: json["phone"],
    email: json["email"],
    name: json["name"],
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "user_type": userType,
    "message": message,
    "user_id": userId,
    "phone": phone,
    "email": email,
    "name": name,
    "access_token": accessToken,
  };
}
