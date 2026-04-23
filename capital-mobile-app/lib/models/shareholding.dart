class Shareholding {
  final String id;
  final String investorId;
  final int sharesHeld;
  final String shareClass;
  final double ownershipPercent;
  final double purchasePrice;
  final double currentValuePerShare;
  final double totalValue;
  final String currency;
  final DateTime purchaseDate;
  final String? certificateUrl;
  final DateTime? createdAt;

  Shareholding({
    required this.id,
    required this.investorId,
    required this.sharesHeld,
    required this.shareClass,
    required this.ownershipPercent,
    required this.purchasePrice,
    required this.currentValuePerShare,
    required this.totalValue,
    this.currency = 'AED',
    required this.purchaseDate,
    this.certificateUrl,
    this.createdAt,
  });

  factory Shareholding.fromJson(Map<String, dynamic> json) => Shareholding(
    id: json['_id'] ?? json['id'] ?? '',
    investorId: json['investorId'] ?? '',
    sharesHeld: json['sharesHeld'] ?? 0,
    shareClass: json['shareClass'] ?? 'Class A',
    ownershipPercent: (json['ownershipPercent'] as num?)?.toDouble() ?? 0,
    purchasePrice: (json['purchasePrice'] as num?)?.toDouble() ?? 0,
    currentValuePerShare: (json['currentValuePerShare'] as num?)?.toDouble() ?? 0,
    totalValue: (json['totalValue'] as num?)?.toDouble() ?? 0,
    currency: json['currency'] ?? 'AED',
    purchaseDate: DateTime.tryParse(json['purchaseDate'] ?? '') ?? DateTime.now(),
    certificateUrl: json['certificateUrl'],
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );

  double get gainLoss => totalValue - (sharesHeld * purchasePrice);
  double get gainLossPercent => (sharesHeld * purchasePrice) > 0 ? (gainLoss / (sharesHeld * purchasePrice)) * 100 : 0;
}
