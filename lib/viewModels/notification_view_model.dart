import 'package:flutter/material.dart' hide Notification;
import 'package:instagram/exceptions/app_exception.dart';
import 'package:instagram/repository/notification_repository.dart';
import 'package:instagram/models/notification.dart';

class NotificationViewModel extends ChangeNotifier {
  final notificationRepository = NotificationRepository();
  bool isLoading = false;
  String? errorMessage;
  List<Notification> notificationList = [];

  Future<void> getNotifications() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final res = await notificationRepository.getUserNotifications();
      notificationList = res.data;
      print("NOTIFICATION LIST IN VIEW MODEL :${notificationList}");
    } on AppException catch (e) {
      errorMessage = e.toString();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
