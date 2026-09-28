import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../core/widgets/template_widgets.dart';
import '../../templates/data/placeholder_templates.dart';

class ExploreSearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

class ExploreCategory extends Notifier<String> {
  @override
  String build() => 'All';

  void select(String value) => state = value;
}

final exploreSearchQueryProvider =
    NotifierProvider<ExploreSearchQuery, String>(ExploreSearchQuery.new);

final exploreCategoryProvider =
    NotifierProvider<ExploreCategory, String>(ExploreCategory.new);

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(exploreSearchQueryProvider).trim().toLowerCase();
    final category = ref.watch(exploreCategoryProvider);

    final filtered = kPlaceholderTemplates.where((t) {
      final matchesCategory =
          category == 'All' || t.category.toLowerCase() == category.toLowerCase();
      final matchesQuery = query.isEmpty ||
          t.name.toLowerCase().contains(query) ||
          t.category.toLowerCase().contains(query) ||
          t.description.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList(growable: false);

    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: AppConstants.maxContentWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(
                title: 'Explore',
                subtitle: 'Find your next style',
                showProfile: false,
              ),
              AppSearchBar(
                hintText: 'Search styles',
                onChanged: (value) {
                  ref.read(exploreSearchQueryProvider.notifier).setQuery(value);
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: kTemplateCategories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: AppSpacing.xs),
                  itemBuilder: (context, index) {
                    final label = kTemplateCategories[index];
                    return CategoryChip(
                      label: label,
                      selected: category == label,
                      onSelected: (_) {
                        ref.read(exploreCategoryProvider.notifier).select(label);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          'No styles available.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : TemplateGrid(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final template = filtered[index];
                          return TemplateCard(
                            name: template.name,
                            category: template.category,
                            imageUrl: template.thumbnailUrl,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${template.name} — detail coming in Phase 2',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
