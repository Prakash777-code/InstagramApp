import 'package:instagram/exceptions/app_exception.dart';
import 'package:instagram/response/api_response.dart';
import 'package:instagram/services/auth_api_service.dart';
import 'package:instagram/utils/helper.dart';

import '../services/secure_storage.dart';

class AuthRepository {
  final authApiservice = AuthApiService();
  final secureStorage = SecureStorage();
  final helper = Helper();
  bool changePasswordRequired = false;

  Future<ApiResponse> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await authApiservice.register(name, email, password);
      helper.handleRequest(response);
      return response;
    } on AppException {
      rethrow;
    }
  }

  Future<ApiResponse> login(String email, String password) async {
    try {
      final response = await authApiservice.login(email, password);
      helper.handleRequest(response);
      if (response.statusCode == 201 &&
          response.data["passwordChangeRequired"] == true) {
        changePasswordRequired = true;
        await secureStorage.saveRefreshToken(response.data["refreshToken"]);
      } else {
        changePasswordRequired = false;
        await secureStorage.saveTokens(
          response.data["accessToken"],
          response.data["refreshToken"],
        );
      }
      return response;
    } on AppException {
      rethrow;
    }
  }

  Future<void> logout() async {
    await secureStorage.clearTokens();
  }

  Future<bool> isLoggedIn() async {
    final accessToken = await secureStorage.getAccessToken();
    final refreshToken = await secureStorage.getRefreshToken();
    if (accessToken == null || refreshToken == null) {
      return false;
    }
    return true;
  }

  Future<ApiResponse> updatePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final response = await authApiservice.updatePassword(
        currentPassword,
        newPassword,
      );
      helper.handleRequest(response);
      return response;
    } on AppException {
      rethrow;
    }
  }
}
