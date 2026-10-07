class CourseData {
  final int? id;
  final String? title;
  final String? size;
  final String? extensionn;
  final String? link;
  final String? course;
  final String? createdAt;

  CourseData({
    this.id,
    this.title,
    this.course,
    this.link,
    this.size,
    this.extensionn,
    this.createdAt,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        id: json["id"] ?? -1,
        title: json["title"] ?? '',
        course: json["course"] ?? '',
        link: json["link"] ?? '',
        size: json["size"] ?? '',
        extensionn: json["extension"] ?? '',
        createdAt: json["created_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "course": course,
        "link": link,
        "size": size,
        "extension": extensionn,
        "created_at": createdAt,
      };
}
