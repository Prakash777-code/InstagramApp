class ProfilePost {
  final int id;
  final int userId;
  final String postUrl;
  final String createdAt;

  ProfilePost({
    required this.id,
    required this.userId,
    required this.postUrl,
    required this.createdAt,
  });

  factory ProfilePost.fromJson(Map<String, dynamic> json) {
    return ProfilePost(
      id: json["id"],
      userId: json["userId"],
      postUrl: json["postUrl"],
      createdAt: json["createdAt"],
    );
  }
}
