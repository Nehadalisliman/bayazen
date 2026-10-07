class Chapter {
  final int? id;
  final int? celeb_id;
  final int? library_id;
  final String? title;
  final String? description;
  final String? folder;
  final String? createdAt;
  final String? updatedAt;

  Chapter({
    this.id,
    this.celeb_id,
    this.library_id,
    this.title,
    this.description,
    this.folder,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'celeb_id': celeb_id,
      'library_id': library_id,
      'title': title,
      'description': description,
      'folder': folder,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Chapter.fromJson(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'] ?? 0,
      celeb_id: map['celeb_id'] ?? 0,
      library_id: map['library_id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      folder: map['folder'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }
}
