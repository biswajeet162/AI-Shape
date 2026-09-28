class StyleTemplate {
  const StyleTemplate({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    required this.description,
    required this.thumbnailUrl,
    required this.trending,
    this.createdAt,
  });

  final String id;
  final String name;
  final String slug;
  final String category;
  final String description;
  final String thumbnailUrl;
  final bool trending;
  final DateTime? createdAt;

  factory StyleTemplate.fromJson(Map<String, dynamic> json) {
    return StyleTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      trending: json['trending'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }
}

class StyleCategory {
  const StyleCategory({
    required this.id,
    required this.name,
    required this.slug,
  });

  final String id;
  final String name;
  final String slug;

  factory StyleCategory.fromJson(Map<String, dynamic> json) {
    return StyleCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
    );
  }
}
