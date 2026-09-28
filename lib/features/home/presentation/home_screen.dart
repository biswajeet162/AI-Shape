import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../core/widgets/template_widgets.dart';
import '../../templates/data/placeholder_templates.dart';

class HomeSearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

final homeSearchQueryProvider =
    NotifierProvider<HomeSearchQuery, String>(HomeSearchQuery.new);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(homeSearchQueryProvider).trim().toLowerCase();
    final trending =
        kPlaceholderTemplates.where((t) => t.trending).toList(growable: false);
    final explore = query.isEmpty
        ? kPlaceholderTemplates
        : kPlaceholderTemplates
            .where(
              (t) =>
                  t.name.toLowerCase().contains(query) ||
                  t.category.toLowerCase().contains(query),
            )
            .toList(growable: false);

    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: AppConstants.maxContentWidth,
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: AppHeader(subtitle: AppConstants.tagline),
              ),
              SliverToBoxAdapter(
                child: Text(
                  AppConstants.homeSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.lg),
              ),
              SliverToBoxAdapter(
                child: AppSearchBar(
                  hintText: 'Search styles',
                  onChanged: (value) {
                    ref.read(homeSearchQueryProvider.notifier).setQuery(value);
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.sectionGap),
              ),
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Trending',
                  actionLabel: 'See all',
                  onAction: () => context.go('/explore'),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 240,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: trending.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: AppSpacing.cardGap),
                    itemBuilder: (context, index) {
                      final template = trending[index];
                      return TemplateCard(
                        width: 148,
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
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.sectionGap),
              ),
              const SliverToBoxAdapter(
                child: SectionHeader(title: 'Explore Styles'),
              ),
              if (explore.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Text(
                      'No styles match your search.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _gridCount(context),
                    crossAxisSpacing: AppSpacing.cardGap,
                    mainAxisSpacing: AppSpacing.lg,
                    childAspectRatio: 0.68,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final template = explore[index];
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
                    childCount: explore.length,
                  ),
                ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xxxl),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _gridCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1100) return 4;
    if (width >= 700) return 3;
    return 2;
  }
}
