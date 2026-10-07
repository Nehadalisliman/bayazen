// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProgramModel {
  final bool? result;
  final String? fullName;
  final List<ProgramsData> programs;
  ProgramModel({
    this.result,
    this.fullName,
    required this.programs,
  });

  factory ProgramModel.fromJson(dynamic json) {
    return ProgramModel(
      programs: json['programs'],
      fullName: json['fullname'],
      result: json['result'],
    );
    // result = json['result'];
    // fullName = json['fullname'];
    // programs = json["programs"];
    // programs = json['programs'].forEach((element) {
    //   programs.add(ProgramsData.fromJson(element));
    // });
  }
}

class ProgramsData {
  final int id;
  final String? name;
  final String image;
  final String description;

  ProgramsData({
    required this.id,
    this.name,
    required this.image,
    required this.description,
  });

  factory ProgramsData.fromJson(dynamic json) => ProgramsData(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      description: json['description'] ?? "");
}
