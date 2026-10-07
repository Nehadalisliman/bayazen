class VideoRes {
  VideoRes({this.result, this.message});

  final bool? result;
  final String? message;

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'message': message,
    };
  }

  factory VideoRes.fromJson(Map<String, dynamic> map) {
    return VideoRes(
      result: map['result'] ?? false,
      message: map['message'] ?? '',
    );
  }
}
