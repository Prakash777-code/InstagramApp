import 'dart:convert';

import 'package:instagram/exceptions/app_exception.dart';
import 'package:instagram/response/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:instagram/services/secure_storage.dart';

class AuthApiService {
  final baseUrl = "https://instagrambackend-aeed.onrender.com";
  //https://instagrambackend-aeed.onrender.com
  final secureStorage = SecureStorage();

  Future<ApiResponse> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("${baseUrl}/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );
    return ApiResponse(
      statusCode: response.statusCode,
      data: jsonDecode(response.body),
    );
  }

  Future<ApiResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${baseUrl}/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    return ApiResponse(
      statusCode: response.statusCode,
      data: jsonDecode(response.body),
    );
  }

  Future<String> refreshToken() async {
    final refreshToken = await secureStorage.getRefreshToken();
    if (refreshToken == null) {
      throw UnauthorizedException("Session expired. Please login again.");
    }
    final response = await http.post(
      Uri.parse("${baseUrl}/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return data["accessToken"];
    }
    throw UnauthorizedException(
      data["message"] ?? "Session expired. Please login again.",
    );
  }
}
