class CompanyValuation {
  final String id;
  final double valuationAmount;
  final String currency;
  final double totalAum;
  final int activeClients;
  final double growthPercent;
  final String period;
  final DateTime valuationDate;
  final String? reportUrl;
  final String? notes;
  final DateTime? createdAt;

  CompanyValuation({
    required this.id,
    required this.valuationAmount,
    this.currency = 'AED',
    required this.totalAum,
    required this.activeClients,
    required this.growthPercent,
    required this.period,
    required this.valuationDate,
    this.reportUrl,
    this.notes,
    this.createdAt,
  });

  factory CompanyValuation.fromJson(Map<String, dynamic> json) => CompanyValuation(
    id: json['_id'] ?? json['id'] ?? '',
    valuationAmount: (json['valuationAmount'] as num?)?.toDouble() ?? 0,
    currency: json['currency'] ?? 'AED',
    totalAum: (json['totalAum'] as num?)?.toDouble() ?? 0,
    activeClients: json['activeClients'] ?? 0,
    growthPercent: (json['growthPercent'] as num?)?.toDouble() ?? 0,
    period: json['period'] ?? '',
    valuationDate: DateTime.tryParse(json['valuationDate'] ?? '') ?? DateTime.now(),
    reportUrl: json['reportUrl'],
    notes: json['notes'],
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );
}
