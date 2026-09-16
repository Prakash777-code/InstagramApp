import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:instagram/exceptions/app_exception.dart';
import 'package:instagram/models/profile.dart';
import 'package:instagram/repository/posts_repository.dart';

class ProfileViewModel extends ChangeNotifier {

  final postsRepository = PostsRepository();
  bool isLoading = false;
  bool buttonLoader = false;
  String? errorMessage;
  Profile? profile;

  Future<void> getUserProfile() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final res = await postsRepository.getUserProfile();
      profile = res.data;
    } on AppException catch (e) {
      errorMessage = e.toString();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> uploadPost(File image) async {
    buttonLoader = true;
    errorMessage = null;
    notifyListeners();
    try {
      await postsRepository.uploadPost(image);
    } on AppException catch (e) {
      errorMessage = e.toString();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      buttonLoader = false;
      notifyListeners();
    }
  }

  Future<void> deletePost(int postId) async {
    buttonLoader = true;
    errorMessage = null;
    notifyListeners();
    try {
      await postsRepository.deletePost(postId);
    } on AppException catch (e) {
      errorMessage = e.toString();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      buttonLoader = false;
      notifyListeners();
    }
  }
}
