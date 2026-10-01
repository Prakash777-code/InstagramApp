import 'package:instagram/exceptions/app_exception.dart';
import 'package:instagram/response/api_response.dart';
import 'package:instagram/services/notification_api_service.dart';
import 'package:instagram/utils/helper.dart';

class NotificationRepository {
  final helper = Helper();
  final notificationApiService = NotificationApiService();

  Future<ApiResponse> getUserNotifications() async {
    try {
      final response = await notificationApiService.getUserNotifications();
      helper.handleRequest(response);
      return response;
    } on AppException {
      rethrow;
    }
  }
}
