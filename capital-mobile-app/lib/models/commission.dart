class Commission {
  final String id;
  final String introducerId;
  final String referralId;
  final String type;
  final double amount;
  final String currency;
  final String status;
  final double? percentage;
  final double? aumGenerated;
  final DateTime? paymentDate;
  final String? paymentReference;
  final DateTime? createdAt;

  Commission({
    required this.id,
    required this.introducerId,
    required this.referralId,
    required this.type,
    required this.amount,
    this.currency = 'AED',
    required this.status,
    this.percentage,
    this.aumGenerated,
    this.paymentDate,
    this.paymentReference,
    this.createdAt,
  });

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
    id: json['_id'] ?? json['id'] ?? '',
    introducerId: json['introducerId'] ?? '',
    referralId: json['referralId'] ?? '',
    type: json['type'] ?? '',
    amount: (json['amount'] as num?)?.toDouble() ?? 0,
    currency: json['currency'] ?? 'AED',
    status: json['status'] ?? 'pending',
    percentage: (json['percentage'] as num?)?.toDouble(),
    aumGenerated: (json['aumGenerated'] as num?)?.toDouble(),
    paymentDate: json['paymentDate'] != null ? DateTime.tryParse(json['paymentDate']) : null,
    paymentReference: json['paymentReference'],
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );

  String get typeLabel {
    switch (type) {
      case 'referral_bonus': return 'Referral Bonus';
      case 'aum_percentage': return 'AUM Commission';
      case 'performance_bonus': return 'Performance Bonus';
      default: return type;
    }
  }
}
