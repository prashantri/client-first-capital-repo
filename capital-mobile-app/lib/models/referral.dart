class Referral {
  final String id;
  final String introducerId;
  final String referralName;
  final String referralEmail;
  final String referralPhone;
  final String status;
  final String? serviceType;
  final String? notes;
  final double? estimatedInvestment;
  final String currency;
  final String? assignedAdvisorId;
  final String? convertedCustomerId;
  final String? source;
  final List<String> tags;
  final DateTime? followUpDate;
  final DateTime? convertedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Referral({
    required this.id,
    required this.introducerId,
    required this.referralName,
    required this.referralEmail,
    required this.referralPhone,
    required this.status,
    this.serviceType,
    this.notes,
    this.estimatedInvestment,
    this.currency = 'AED',
    this.assignedAdvisorId,
    this.convertedCustomerId,
    this.source,
    this.tags = const [],
    this.followUpDate,
    this.convertedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
    id: json['_id'] ?? json['id'] ?? '',
    introducerId: json['introducerId'] ?? '',
    referralName: json['referralName'] ?? '',
    referralEmail: json['referralEmail'] ?? '',
    referralPhone: json['referralPhone'] ?? '',
    status: json['status'] ?? 'new',
    serviceType: json['serviceType'],
    notes: json['notes'],
    estimatedInvestment: (json['estimatedInvestment'] as num?)?.toDouble(),
    currency: json['currency'] ?? 'AED',
    assignedAdvisorId: json['assignedAdvisorId'],
    convertedCustomerId: json['convertedCustomerId'],
    source: json['source'],
    tags: List<String>.from(json['tags'] ?? []),
    followUpDate: json['followUpDate'] != null ? DateTime.tryParse(json['followUpDate']) : null,
    convertedAt: json['convertedAt'] != null ? DateTime.tryParse(json['convertedAt']) : null,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
  );

  Map<String, dynamic> toJson() => {
    'referralName': referralName,
    'referralEmail': referralEmail,
    'referralPhone': referralPhone,
    if (serviceType != null) 'serviceType': serviceType,
    if (notes != null) 'notes': notes,
    if (estimatedInvestment != null) 'estimatedInvestment': estimatedInvestment,
    'currency': currency,
    if (source != null) 'source': source,
    if (tags.isNotEmpty) 'tags': tags,
    if (followUpDate != null) 'followUpDate': followUpDate!.toIso8601String(),
  };
}
