class EducationContent {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String category;
  final String author;
  final String? thumbnailUrl;
  final int readTimeMinutes;
  final List<String> tags;
  final bool isPublished;
  final DateTime? publishedAt;
  final int viewCount;
  final DateTime? createdAt;

  EducationContent({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.category,
    required this.author,
    this.thumbnailUrl,
    this.readTimeMinutes = 5,
    this.tags = const [],
    this.isPublished = false,
    this.publishedAt,
    this.viewCount = 0,
    this.createdAt,
  });

  factory EducationContent.fromJson(Map<String, dynamic> json) => EducationContent(
    id: json['_id'] ?? json['id'] ?? '',
    title: json['title'] ?? '',
    summary: json['summary'] ?? '',
    content: json['content'] ?? '',
    category: json['category'] ?? '',
    author: json['author'] ?? '',
    thumbnailUrl: json['thumbnailUrl'],
    readTimeMinutes: json['readTimeMinutes'] ?? 5,
    tags: List<String>.from(json['tags'] ?? []),
    isPublished: json['isPublished'] ?? false,
    publishedAt: json['publishedAt'] != null ? DateTime.tryParse(json['publishedAt']) : null,
    viewCount: json['viewCount'] ?? 0,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
  );
}
