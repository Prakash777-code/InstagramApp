import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instagram/models/notification.dart';
import 'package:instagram/response/api_response.dart';
import 'package:instagram/services/auth_api_service.dart';
import 'package:instagram/services/secure_storage.dart';

class NotificationApiService {
  final baseUrl = "https://instagrambackend-aeed.onrender.com";
  final secureStorage = SecureStorage();
  final authApiService = AuthApiService();

  Future<ApiResponse> getUserNotifications() async {
    print("NOTIFICATION API ");
    var accessToken = await secureStorage.getAccessToken();
    var response = await http.get(
      Uri.parse("${baseUrl}/posts/notification"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );
    if (response.statusCode == 401) {
      accessToken = await authApiService.refreshToken();
      await secureStorage.saveAccessToken(accessToken);
      response = await http.get(
        Uri.parse("${baseUrl}/posts/notification"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );
    }
    print("NOTIFICATION API RESPONSE : ${response.body}");
    final data = json.decode(response.body);
    final notificationList = (data["data"] as List)
        .map((item) => Notification.fromJson(item))
        .toList();
    return ApiResponse(statusCode: response.statusCode, data: notificationList);
  }
}
