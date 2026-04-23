import '../core/network/api_client.dart';
import '../models/notification.dart';

class NotificationService {
  Future<List<AppNotification>> getAll({int page = 1, int limit = 20}) async {
    final response = await api.get('/notifications', queryParameters: {
      'page': page,
      'limit': limit,
    });
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => AppNotification.fromJson(e)).toList();
  }

  Future<void> markAsRead(String id) async {
    await api.patch('/notifications/$id/read');
  }

  Future<void> markAllRead() async {
    await api.patch('/notifications/read-all');
  }
}
