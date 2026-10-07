class BrowseCourseModel {
  final int? id;
  final String? title;
  final String? size;
  final String? extensionn;
  final String? link;
  final String? createdAt;

  BrowseCourseModel({
    this.id,
    this.title,
    this.link,
    this.size,
    this.extensionn,
    this.createdAt,
  });

  factory BrowseCourseModel.fromJson(Map<String, dynamic> json) =>
      BrowseCourseModel(
        id: json["id"] ?? -1,
        title: json["title"] ?? '',
        link: json["link"] ?? '',
        size: json["size"] ?? '',
        extensionn: json["extension"] ?? '',
        createdAt: json["created_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "size": size,
        "extension": extensionn,
        "created_at": createdAt,
      };
}
