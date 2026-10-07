class LibraryItem {
  final int? id;
  final String? title;
  final String? description;

  LibraryItem({
    this.id,
    this.title,
    this.description,
  });

  factory LibraryItem.fromJson(Map<String, dynamic> json) {
    return LibraryItem(
      id: json['id'] ?? -1,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
