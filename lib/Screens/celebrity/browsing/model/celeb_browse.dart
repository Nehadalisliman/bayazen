//celeb_browse.dart

class CelebBrowse {
  final int? id;
  final String? name;
  final String? spec;
  final String? image;

  CelebBrowse({this.id, this.name, this.spec, this.image});

  factory CelebBrowse.fromJson(Map<String, dynamic> json) {
    return CelebBrowse(
      id: json['id'] ?? -1,
      name: json['name'] ?? "",
      spec: json['spec'] ?? "",
      image: json['image'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'spec': spec,
      'image': image,
    };
  }
}
