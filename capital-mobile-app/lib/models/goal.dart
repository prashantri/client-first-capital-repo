class Goal {
  final String id;
  final String customerId;
  final String name;
  final String type;
  final double targetAmount;
  final double currentAmount;
  final String currency;
  final DateTime targetDate;
  final double? monthlyContribution;
  final String status;
  final double progressPercent;
  final String? notes;
  final DateTime? createdAt;

  Goal({
    required this.id,
    required this.customerId,
    required this.name,
    required this.type,
    required this.targetAmount,
    this.currentAmount = 0,
    this.currency = 'AED',
    required this.targetDate,
    this.monthlyContribution,
    required this.status,
    this.progressPercent = 0,
    this.notes,
    this.createdAt,
  });

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
    id: json['_id'] ?? json['id'] ?? '',
    customerId: json['customerId'] ?? '',
    name: json['name'] ?? '',
    type: json['type'] ?? 'custom',
    targetAmount: (json['targetAmount'] as num?)?.toDouble() ?? 0,
    currentAmount: (json['currentAmount'] as num?)?.toDouble() ?? 0,
    currency: json['currency'] ?? 'AED',
    targetDate: DateTime.tryParse(json['targetDate'] ?? '') ?? DateTime.now(),
    monthlyContribution: (json['monthlyContribution'] as num?)?.toDouble(),
    status: json['status'] ?? 'active',
    progressPercent: (json['progressPercent'] as num?)?.toDouble() ?? 0,
    notes: json['notes'],
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'targetAmount': targetAmount,
    'currentAmount': currentAmount,
    'targetDate': targetDate.toIso8601String(),
    if (monthlyContribution != null) 'monthlyContribution': monthlyContribution,
    if (notes != null) 'notes': notes,
  };

  String get typeLabel {
    switch (type) {
      case 'retirement': return 'Retirement';
      case 'education': return 'Education';
      case 'home_purchase': return 'Home Purchase';
      case 'wealth_building': return 'Wealth Building';
      case 'emergency_fund': return 'Emergency Fund';
      default: return 'Custom';
    }
  }
}
