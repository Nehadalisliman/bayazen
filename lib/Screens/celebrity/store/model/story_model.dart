class StoryModel {
  final int? id;
  final String? description;
  final List<String>? imagesLinks;
  final String? videoLink;

  StoryModel({
    this.id,
    this.description,
    this.imagesLinks,
    this.videoLink,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? "",
      imagesLinks: json['images_links'] != null
          ? List<String>.from(json['images_links'])
          : [],
      videoLink: json['video_link'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'images_links': imagesLinks,
      'video_link': videoLink,
    };
  }
}
