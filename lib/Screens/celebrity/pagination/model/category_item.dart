class CategoryItem {
  final int? id;
  final String? title;

  CategoryItem({
    this.id,
    this.title,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? -1,
      title: json['title'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
