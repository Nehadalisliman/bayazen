class Libraries {
  Libraries({
    this.folder,
    this.description,
    this.id,
    this.celeb_id,
    this.program_id,
    this.title,
  });

  String? title;
  String? description;
  String? folder;
  int? id;
  String? celeb_id;
  String? program_id;

  // List<Video> videos;

  Libraries copyWith({
    String? title,
    String? folder,
    int? id,
    int? program_id,
    int? celeb_id,
    String? description,
    //List<Video> videos,
  }) =>
      Libraries(
        folder: folder ?? this.folder,
        id: id ?? this.id,
        celeb_id: celeb_id as String? ?? this.celeb_id,
        description: description ?? this.description,
        program_id: program_id as String? ?? this.program_id,
        title: program_id as String? ?? this.title,
      );
  factory Libraries.fromJson(Map<String, dynamic> json) => Libraries(
        celeb_id: json["celeb_id"],
        program_id: json["program_id"],
        title: json["title"],
        description: json["description"],
        folder: json["folder"],
        id: json["id"],
      );
}

class Video {
  Video({
    this.id,
    this.title,
    this.video,
    this.description,
    this.createdAt,
  });

  int? id;
  String? title;
  String? video;
  String? description;
  DateTime? createdAt;

  Video copyWith({
    int? id,
    String? title,
    String? video,
    String? description,
    DateTime? createdAt,
  }) =>
      Video(
        id: id ?? this.id,
        title: title ?? this.title,
        video: video ?? this.video,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        video: json["video"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "video": video,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
      };
}
