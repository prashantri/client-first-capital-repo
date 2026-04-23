class Appointment {
  final String id;
  final String customerId;
  final String advisorId;
  final String type;
  final String status;
  final DateTime scheduledAt;
  final int durationMinutes;
  final String? location;
  final String? meetingLink;
  final String? notes;
  final String? advisorNotes;
  final DateTime? completedAt;
  final DateTime? createdAt;

  Appointment({
    required this.id,
    required this.customerId,
    required this.advisorId,
    required this.type,
    required this.status,
    required this.scheduledAt,
    this.durationMinutes = 30,
    this.location,
    this.meetingLink,
    this.notes,
    this.advisorNotes,
    this.completedAt,
    this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json['_id'] ?? json['id'] ?? '',
    customerId: json['customerId'] ?? '',
    advisorId: json['advisorId'] ?? '',
    type: json['type'] ?? 'general',
    status: json['status'] ?? 'requested',
    scheduledAt: DateTime.tryParse(json['scheduledAt'] ?? '') ?? DateTime.now(),
    durationMinutes: json['durationMinutes'] ?? 30,
    location: json['location'],
    meetingLink: json['meetingLink'],
    notes: json['notes'],
    advisorNotes: json['advisorNotes'],
    completedAt: json['completedAt'] != null ? DateTime.tryParse(json['completedAt']) : null,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'scheduledAt': scheduledAt.toIso8601String(),
    'durationMinutes': durationMinutes,
    if (location != null) 'location': location,
    if (notes != null) 'notes': notes,
  };

  String get typeLabel {
    switch (type) {
      case 'initial_consultation': return 'Initial Consultation';
      case 'portfolio_review': return 'Portfolio Review';
      case 'risk_assessment': return 'Risk Assessment';
      case 'goal_planning': return 'Goal Planning';
      default: return 'General';
    }
  }
}
