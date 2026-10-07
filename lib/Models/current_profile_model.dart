// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class UpdateProfileModel {
  final String? name;
  final String? occupation;
  final String? bio;
  final String? image;
  final String? email;
  final String? phone;

  UpdateProfileModel({
    this.name,
    this.occupation,
    this.bio,
    this.image,
    this.email,
    this.phone,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        name: json["fullname"] ?? "",
        occupation: json["occupation"] ?? "لا يوجد",
        bio: json["bio"] ?? "لا يوجد",
        image: json["image"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fullname": name,
        "occupation": occupation,
        "bio": bio,
        "image": image,
        "email": email,
        "phone": phone,
      };
}
