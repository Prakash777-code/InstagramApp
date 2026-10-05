class NotificationList {
  final int id;
  final String imageUrl;
  final String userName;
  final String createdAt;

  NotificationList({
    required this.id,
    required this.imageUrl,
    required this.userName,
    required this.createdAt,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) {
    return NotificationList(
      id: json["id"] as int? ?? 0,
      imageUrl: json["imageUrl"],
      userName: json["userName"] ?? "User",
      createdAt: json["created_at"] ?? "Now",
    );
  }
}
