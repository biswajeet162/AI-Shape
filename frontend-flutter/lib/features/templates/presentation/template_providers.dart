import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/template_repository.dart';
import '../models/style_template.dart';

final templatesProvider =
    FutureProvider.autoDispose<List<StyleTemplate>>((ref) async {
  return ref.watch(templateRepositoryProvider).fetchTemplates();
});

final trendingTemplatesProvider =
    FutureProvider.autoDispose<List<StyleTemplate>>((ref) async {
  return ref.watch(templateRepositoryProvider).fetchTemplates(trending: true);
});

final categoriesProvider =
    FutureProvider.autoDispose<List<StyleCategory>>((ref) async {
  return ref.watch(templateRepositoryProvider).fetchCategories();
});

final templateDetailProvider =
    FutureProvider.autoDispose.family<StyleTemplate, String>((ref, id) async {
  return ref.watch(templateRepositoryProvider).fetchTemplate(id);
});

final exploreTemplatesProvider = FutureProvider.autoDispose
    .family<List<StyleTemplate>, ({String category, String query})>(
  (ref, filter) async {
    final templates = await ref.watch(templateRepositoryProvider).fetchTemplates(
          category: filter.category == 'All' ? null : filter.category,
        );

    final query = filter.query.trim().toLowerCase();
    if (query.isEmpty) return templates;

    return templates
        .where(
          (t) =>
              t.name.toLowerCase().contains(query) ||
              t.category.toLowerCase().contains(query) ||
              t.description.toLowerCase().contains(query),
        )
        .toList(growable: false);
  },
);
