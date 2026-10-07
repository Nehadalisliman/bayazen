// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class CeleResponseModel {
  CeleResponseModel({
    this.result,
    this.message,
    this.data,
    this.userId,
  });

  bool? result;
  String? message;
  List<Cele>? data;
  String? userId;

  CeleResponseModel copyWith({
    bool? result,
    String? message,
    List<Cele>? data,
    String? userId,
  }) =>
      CeleResponseModel(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
        userId: userId ?? this.userId,
      );

  factory CeleResponseModel.fromJson(Map<String, dynamic> json) =>
      CeleResponseModel(
        result: json["result"] ?? false,
        message: json["message"] ?? "",
        data: (json["data"] != [] || json["data"] == null)
            ? List<Cele>.from(json["data"].map((x) => Cele.fromJson(x)))
            : [],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "user_id": userId,
      };
}

class Cele {
  Cele({
    this.id,
    this.fullname,
    this.image,
    this.spec,
  });

  int? id;
  String? fullname;
  String? image;
  String? spec;

  Cele copyWith({
    int? id,
    String? fullname,
    String? image,
    String? spec,
  }) =>
      Cele(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        image: image ?? this.image,
        spec: spec ?? this.spec,
      );

  factory Cele.fromJson(Map<String, dynamic> json) => Cele(
        id: json["id"],
        fullname: json["fullname"],
        image: json["image"],
        spec: json["spec"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "image": image,
        "spec": spec,
      };
}
