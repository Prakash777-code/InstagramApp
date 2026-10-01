class Notification {
  final int id;
  final String imageUrl;
  final String userName;
  final String createdAt;

  Notification({
    required this.id,
    required this.imageUrl,
    required this.userName,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json["id"] as int? ?? 0,
      imageUrl: json["imageUrl"],
      userName: json["userName"],
      createdAt: json["created_at"],
    );
  }
}
