import 'package:flutter/material.dart';
import '../models/notification.dart';
import '../services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _service = NotificationService();

  List<AppNotification> _notifications = [];
  bool _isLoading = false;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _notifications = await _service.getAll();
    } catch (_) {}
    _isLoading = false;
    notifyListeners();
  }

  Future<void> markAsRead(String id) async {
    await _service.markAsRead(id);
    final idx = _notifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      _notifications[idx] = AppNotification(
        id: _notifications[idx].id,
        userId: _notifications[idx].userId,
        type: _notifications[idx].type,
        title: _notifications[idx].title,
        message: _notifications[idx].message,
        data: _notifications[idx].data,
        isRead: true,
        readAt: DateTime.now(),
        createdAt: _notifications[idx].createdAt,
      );
      notifyListeners();
    }
  }

  Future<void> markAllRead() async {
    await _service.markAllRead();
    _notifications = _notifications.map((n) => AppNotification(
      id: n.id,
      userId: n.userId,
      type: n.type,
      title: n.title,
      message: n.message,
      data: n.data,
      isRead: true,
      readAt: DateTime.now(),
      createdAt: n.createdAt,
    )).toList();
    notifyListeners();
  }
}
