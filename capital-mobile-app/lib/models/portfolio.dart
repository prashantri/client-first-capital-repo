class Holding {
  final String symbol;
  final String name;
  final String assetClass;
  final int quantity;
  final double avgBuyPrice;
  final double currentPrice;
  final double marketValue;
  final double gainLoss;
  final double gainLossPercent;
  final String currency;

  Holding({
    required this.symbol,
    required this.name,
    required this.assetClass,
    required this.quantity,
    required this.avgBuyPrice,
    required this.currentPrice,
    required this.marketValue,
    required this.gainLoss,
    required this.gainLossPercent,
    this.currency = 'AED',
  });

  factory Holding.fromJson(Map<String, dynamic> json) => Holding(
    symbol: json['symbol'] ?? '',
    name: json['name'] ?? '',
    assetClass: json['assetClass'] ?? '',
    quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    avgBuyPrice: (json['avgBuyPrice'] as num?)?.toDouble() ?? 0,
    currentPrice: (json['currentPrice'] as num?)?.toDouble() ?? 0,
    marketValue: (json['marketValue'] as num?)?.toDouble() ?? 0,
    gainLoss: (json['gainLoss'] as num?)?.toDouble() ?? 0,
    gainLossPercent: (json['gainLossPercent'] as num?)?.toDouble() ?? 0,
    currency: json['currency'] ?? 'AED',
  );
}

class Allocation {
  final double equities;
  final double bonds;
  final double realEstate;
  final double cash;
  final double? alternatives;

  Allocation({required this.equities, required this.bonds, required this.realEstate, required this.cash, this.alternatives});

  factory Allocation.fromJson(Map<String, dynamic> json) => Allocation(
    equities: (json['equities'] as num?)?.toDouble() ?? 0,
    bonds: (json['bonds'] as num?)?.toDouble() ?? 0,
    realEstate: (json['realEstate'] as num?)?.toDouble() ?? 0,
    cash: (json['cash'] as num?)?.toDouble() ?? 0,
    alternatives: (json['alternatives'] as num?)?.toDouble(),
  );
}

class Portfolio {
  final String id;
  final String customerId;
  final String advisorId;
  final String portfolioName;
  final double totalValue;
  final double investedAmount;
  final String currency;
  final String riskLevel;
  final Allocation? allocation;
  final List<Holding> holdings;
  final double ytdReturn;
  final double absoluteGain;
  final double disciplineScore;
  final DateTime? inceptionDate;
  final bool isActive;
  final DateTime? createdAt;

  Portfolio({
    required this.id,
    required this.customerId,
    required this.advisorId,
    required this.portfolioName,
    required this.totalValue,
    required this.investedAmount,
    this.currency = 'AED',
    required this.riskLevel,
    this.allocation,
    this.holdings = const [],
    this.ytdReturn = 0,
    this.absoluteGain = 0,
    this.disciplineScore = 0,
    this.inceptionDate,
    this.isActive = true,
    this.createdAt,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
    id: json['_id'] ?? json['id'] ?? '',
    customerId: json['customerId'] ?? '',
    advisorId: json['advisorId'] ?? '',
    portfolioName: json['portfolioName'] ?? '',
    totalValue: (json['totalValue'] as num?)?.toDouble() ?? 0,
    investedAmount: (json['investedAmount'] as num?)?.toDouble() ?? 0,
    currency: json['currency'] ?? 'AED',
    riskLevel: json['riskLevel'] ?? 'moderate',
    allocation: json['allocation'] != null ? Allocation.fromJson(json['allocation']) : null,
    holdings: (json['holdings'] as List?)?.map((h) => Holding.fromJson(h)).toList() ?? [],
    ytdReturn: (json['ytdReturn'] as num?)?.toDouble() ?? 0,
    absoluteGain: (json['absoluteGain'] as num?)?.toDouble() ?? 0,
    disciplineScore: (json['disciplineScore'] as num?)?.toDouble() ?? 0,
    inceptionDate: json['inceptionDate'] != null ? DateTime.tryParse(json['inceptionDate']) : null,
    isActive: json['isActive'] ?? true,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );

  double get returnPercent => investedAmount > 0 ? ((totalValue - investedAmount) / investedAmount) * 100 : 0;
}
