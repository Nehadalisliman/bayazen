class CourseBrowsing {
  final int? id;
  final String? title;
  final String? link;
  final String? size;
  final String? eXtension;
  final String? created_at;

  CourseBrowsing(
      {this.id,
      this.title,
      this.link,
      this.size,
      this.eXtension,
      this.created_at});

  factory CourseBrowsing.fromJson(Map<String, dynamic> json) {
    return CourseBrowsing(
      id: json['id'] ?? -1,
      title: json['title'] ?? "",
      size: json['size'] ?? "",
      eXtension: json['extension'] ?? "",
      link: json['link'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'size': size,
      'extension': eXtension,
      'link': link,
    };
  }
}
