import 'package:instagram/models/profile_post.dart';

class Profile {
  final String name;
  final List<ProfilePost> posts;

  Profile({required this.name, required this.posts});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json["name"],
      posts: (json["posts"] as List)
          .map((post) => ProfilePost.fromJson(post))
          .toList(),
    );
  }
}
