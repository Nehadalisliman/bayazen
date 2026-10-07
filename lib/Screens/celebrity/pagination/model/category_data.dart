class CategoryData {
  final int? id;
  final int? celebId;
  final String? programId;
  final int? libraryId;
  final String? title;
  final String? course;
  final String? link;
  final String? folder;
  final String? size;
  final String? description;
  final String? extensionn;
  final String? createdAt;
  final String? updatedAt;

  CategoryData({
    this.id,
    this.celebId,
    this.programId,
    this.libraryId,
    this.title,
    this.course,
    this.link,
    this.size,
    this.description,
    this.folder,
    this.extensionn,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"] ?? -1,
        celebId: json["celeb_id"] ?? '',
        programId: json["program_id"] ?? '',
        libraryId: json["library_id"] ?? '',
        title: json["title"] ?? '',
        course: json["course"] ?? '',
        link: json["link"] ?? '',
        size: json["size"] ?? '',
        folder: json["folder"] ?? '',
        description: json["description"] ?? '',
        extensionn: json["extension"] ?? '',
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "celeb_id": celebId,
        "program_id": programId,
        "library_id": libraryId,
        "title": title,
        "course": course,
        "link": link,
        "size": size,
        "folder": folder,
        "extension": extensionn,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
