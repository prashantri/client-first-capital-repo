class AppNotification {
  final String id;
  final String userId;
  final String type;
  final String title;
  final String message;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime? readAt;
  final DateTime? createdAt;

  AppNotification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.message,
    this.data,
    this.isRead = false,
    this.readAt,
    this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
    id: json['_id'] ?? json['id'] ?? '',
    userId: json['userId'] ?? '',
    type: json['type'] ?? 'system',
    title: json['title'] ?? '',
    message: json['message'] ?? '',
    data: json['data'] as Map<String, dynamic>?,
    isRead: json['isRead'] ?? false,
    readAt: json['readAt'] != null ? DateTime.tryParse(json['readAt']) : null,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );
}
