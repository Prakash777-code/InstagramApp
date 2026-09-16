import 'package:instagram/exceptions/app_exception.dart';
import 'package:instagram/response/api_response.dart';
import 'package:instagram/services/auth_api_service.dart';
import 'package:instagram/utils/helper.dart';

import '../services/secure_storage.dart';

class AuthRepository {
  final authApiservice = AuthApiService();
  final secureStorage = SecureStorage();
  final helper = Helper();

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
      if (response.statusCode == 201) {
        await secureStorage.saveTokens(
          response.data["accessToken"],
          response.data["refreshToken"],
        );
      }
      helper.handleRequest(response);
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
    if (accessToken == null && refreshToken == null) {
      return false;
    }
    return true;
  }
}
