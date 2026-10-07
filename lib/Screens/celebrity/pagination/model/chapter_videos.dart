class ChapterVideos {
  final int? id;
  final int? celeb_id;
  final int? program_id;
  final int? library_id;
  final int? chapter_id;
  final String? title;
  final String? video;
  final String? link;
  final String? description;
  final String? created_at;
  final String? updated_at;

  ChapterVideos(
      {this.id,
      this.celeb_id,
      this.program_id,
      this.library_id,
      this.chapter_id,
      this.title,
      this.video,
      this.link,
      this.description,
      this.created_at,
      this.updated_at});

  factory ChapterVideos.fromJson(Map<String, dynamic> json) {
    return ChapterVideos(
      id: json['id'] ?? -1,
      celeb_id: json['celeb_id'],
      program_id: json['program_id'],
      library_id: json['library_id'],
      chapter_id: json['chapter_id'],
      title: json['title'],
      video: json['video'],
      link: json['link'],
      description: json['description'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'celeb_id': celeb_id,
      'program_id': program_id,
      'library_id': library_id,
      'chapter_id': chapter_id,
      'title': title,
      'video': video,
      'link': link,
      'description': description,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}
