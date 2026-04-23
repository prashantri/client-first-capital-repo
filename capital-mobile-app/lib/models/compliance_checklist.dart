class ComplianceChecklist {
  final String id;
  final String advisorId;
  final String title;
  final String description;
  final String category;
  final bool isCompleted;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final String? notes;
  final DateTime? createdAt;

  ComplianceChecklist({
    required this.id,
    required this.advisorId,
    required this.title,
    required this.description,
    required this.category,
    this.isCompleted = false,
    this.dueDate,
    this.completedAt,
    this.notes,
    this.createdAt,
  });

  factory ComplianceChecklist.fromJson(Map<String, dynamic> json) => ComplianceChecklist(
    id: json['_id'] ?? json['id'] ?? '',
    advisorId: json['advisorId'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    category: json['category'] ?? '',
    isCompleted: json['isCompleted'] ?? false,
    dueDate: json['dueDate'] != null ? DateTime.tryParse(json['dueDate']) : null,
    completedAt: json['completedAt'] != null ? DateTime.tryParse(json['completedAt']) : null,
    notes: json['notes'],
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );

  bool get isOverdue => dueDate != null && !isCompleted && dueDate!.isBefore(DateTime.now());
}
