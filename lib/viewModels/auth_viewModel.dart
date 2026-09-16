import 'package:flutter/material.dart';
import 'package:instagram/exceptions/app_exception.dart';
import 'package:instagram/repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final authRepository = AuthRepository();
  bool isLoading = false;
  String? errorMessage;
  bool isLoggedIn = false;

  Future<void> register(String name, String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await authRepository.register(name, email, password);
    } on AppException catch (e) {
      errorMessage = e.toString();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await authRepository.login(email, password);
      isLoggedIn = true;
    } on AppException catch (e) {
      errorMessage = e.toString();
    } catch (e) {
      isLoggedIn = false;
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
  }

  Future<void> checkAuthentication() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }
}
