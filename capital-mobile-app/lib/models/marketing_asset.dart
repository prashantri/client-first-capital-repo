class MarketingAsset {
  final String id;
  final String title;
  final String description;
  final String type;
  final String fileUrl;
  final String? thumbnailUrl;
  final String category;
  final List<String> tags;
  final int downloadCount;
  final bool isActive;
  final DateTime? createdAt;

  MarketingAsset({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.fileUrl,
    this.thumbnailUrl,
    required this.category,
    this.tags = const [],
    this.downloadCount = 0,
    this.isActive = true,
    this.createdAt,
  });

  factory MarketingAsset.fromJson(Map<String, dynamic> json) => MarketingAsset(
    id: json['_id'] ?? json['id'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    type: json['type'] ?? '',
    fileUrl: json['fileUrl'] ?? '',
    thumbnailUrl: json['thumbnailUrl'],
    category: json['category'] ?? '',
    tags: List<String>.from(json['tags'] ?? []),
    downloadCount: json['downloadCount'] ?? 0,
    isActive: json['isActive'] ?? true,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );

  String get typeLabel {
    switch (type) {
      case 'brochure': return 'Brochure';
      case 'video': return 'Video';
      case 'infographic': return 'Infographic';
      case 'social_post': return 'Social Post';
      case 'presentation': return 'Presentation';
      case 'report': return 'Report';
      default: return type;
    }
  }
}
