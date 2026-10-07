class VideoBrwosing {
  final int? id;
  final String? title;
  final String? description;
  final String? link;
  final String? created_at;

  VideoBrwosing({
    this.id,
    this.title,
    this.description,
    this.link,
    this.created_at,
  });

  factory VideoBrwosing.fromJson(Map<String, dynamic> json) {
    return VideoBrwosing(
      id: json['id'] ?? -1,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      link: json['link'] ?? "",
      created_at: json['created_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'link': link,
      'created_at': created_at,
    };
  }
}
