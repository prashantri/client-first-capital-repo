class LeaderboardEntry {
  final String id;
  final String introducerId;
  final int rank;
  final int totalReferrals;
  final int convertedReferrals;
  final double totalAumGenerated;
  final double totalCommissionsEarned;
  final String currency;
  final String period;
  final String periodType;
  final List<String> badges;
  final String? introducerName;

  LeaderboardEntry({
    required this.id,
    required this.introducerId,
    required this.rank,
    this.totalReferrals = 0,
    this.convertedReferrals = 0,
    this.totalAumGenerated = 0,
    this.totalCommissionsEarned = 0,
    this.currency = 'AED',
    required this.period,
    required this.periodType,
    this.badges = const [],
    this.introducerName,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) => LeaderboardEntry(
    id: json['_id'] ?? json['id'] ?? '',
    introducerId: json['introducerId'] is Map ? json['introducerId']['_id'] ?? '' : json['introducerId'] ?? '',
    rank: json['rank'] ?? 0,
    totalReferrals: json['totalReferrals'] ?? 0,
    convertedReferrals: json['convertedReferrals'] ?? 0,
    totalAumGenerated: (json['totalAumGenerated'] as num?)?.toDouble() ?? 0,
    totalCommissionsEarned: (json['totalCommissionsEarned'] as num?)?.toDouble() ?? 0,
    currency: json['currency'] ?? 'AED',
    period: json['period'] ?? '',
    periodType: json['periodType'] ?? 'monthly',
    badges: List<String>.from(json['badges'] ?? []),
    introducerName: json['introducerId'] is Map ? json['introducerId']['fullName'] : null,
  );

  double get conversionRate => totalReferrals > 0 ? (convertedReferrals / totalReferrals) * 100 : 0;
}
