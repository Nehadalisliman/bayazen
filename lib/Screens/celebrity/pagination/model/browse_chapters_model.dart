class BrowseChapterModel {
  final int? id;
  final String? title;
  final String? description;

  BrowseChapterModel({
    this.id,
    this.title,
    this.description,
  });

  factory BrowseChapterModel.fromJson(Map<String, dynamic> json) =>
      BrowseChapterModel(
        id: json["id"] ?? -1,
        title: json["title"] ?? '',
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
