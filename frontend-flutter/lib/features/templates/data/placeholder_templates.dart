/// Placeholder template model for Phase 1 UI.
/// Replaced by API-backed models in Phase 2.
class TemplatePreview {
  const TemplatePreview({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.thumbnailUrl,
    this.trending = false,
  });

  final String id;
  final String name;
  final String category;
  final String description;
  final String thumbnailUrl;
  final bool trending;
}

const List<String> kTemplateCategories = [
  'All',
  'Retro',
  'Vintage',
  'Anime',
  'Cartoon',
  'Cinematic',
  'Professional',
  'Art',
];

/// Visual placeholders using curated Unsplash portraits.
const List<TemplatePreview> kPlaceholderTemplates = [
  TemplatePreview(
    id: 'retro-90s',
    name: '90s Retro',
    category: 'Retro',
    description:
        'Give your portrait a nostalgic 1990s film photography look.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600&q=80',
    trending: true,
  ),
  TemplatePreview(
    id: 'vintage-80s',
    name: '80s Vintage',
    category: 'Vintage',
    description: 'Warm analog tones with classic 1980s portrait vibes.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600&q=80',
    trending: true,
  ),
  TemplatePreview(
    id: 'anime-portrait',
    name: 'Anime Portrait',
    category: 'Anime',
    description: 'A polished anime-inspired illustration of your likeness.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600&q=80',
    trending: true,
  ),
  TemplatePreview(
    id: 'cartoon',
    name: 'Cartoon',
    category: 'Cartoon',
    description: 'Playful cartoon styling while keeping you recognizable.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=600&q=80',
    trending: true,
  ),
  TemplatePreview(
    id: 'cinematic-portrait',
    name: 'Cinematic Portrait',
    category: 'Cinematic',
    description: 'Dramatic cinematic lighting and film-still atmosphere.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=600&q=80',
  ),
  TemplatePreview(
    id: 'vintage-film',
    name: 'Vintage Film',
    category: 'Vintage',
    description: 'Soft grain and faded film colors for timeless portraits.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=600&q=80',
  ),
  TemplatePreview(
    id: 'professional-portrait',
    name: 'Professional Portrait',
    category: 'Professional',
    description: 'Clean studio lighting for a polished professional look.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600&q=80',
  ),
  TemplatePreview(
    id: 'watercolor',
    name: 'Watercolor',
    category: 'Art',
    description: 'Delicate watercolor brushwork with soft artistic washes.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&q=80',
  ),
  TemplatePreview(
    id: 'comic-art',
    name: 'Comic Art',
    category: 'Cartoon',
    description: 'Bold comic-book lines, ink, and graphic shading.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=600&q=80',
  ),
  TemplatePreview(
    id: 'royal-portrait',
    name: 'Royal Portrait',
    category: 'Art',
    description: 'Regal classical portrait styling with rich detail.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=600&q=80',
  ),
];
