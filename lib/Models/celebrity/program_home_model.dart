class ProgramHomeModel {
  bool? result;
  String? fullName;
  List<ProgramsHomeData> programs = [];

  ProgramHomeModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    fullName = json['fullname'];
    json['programs'].forEach((element) {
      programs.add(ProgramsHomeData.fromJson(element));
    });
  }
}

class ProgramsHomeData {
  final int id;
  final String? name;
  final String image;
  final String description;

  ProgramsHomeData({
    required this.id,
    this.name,
    required this.image,
    required this.description,
  });

  factory ProgramsHomeData.fromJson(Map<String, dynamic> json) =>
      ProgramsHomeData(
          id: json['id'] ?? 0,
          name: json['name'] ?? "",
          image: json['image'] ?? "",
          description: json['description'] ?? "");
}
