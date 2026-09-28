import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/empty_error_states.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../core/widgets/template_widgets.dart';
import '../../templates/presentation/template_providers.dart';

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
    final trendingAsync = ref.watch(trendingTemplatesProvider);
    final templatesAsync = ref.watch(templatesProvider);

    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: AppConstants.maxContentWidth,
          child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(trendingTemplatesProvider);
              ref.invalidate(templatesProvider);
              await Future.wait([
                ref.read(trendingTemplatesProvider.future),
                ref.read(templatesProvider.future),
              ]);
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
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
                    child: trendingAsync.when(
                      loading: () => ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: AppSpacing.cardGap),
                        itemBuilder: (context, index) =>
                            const SkeletonCard(width: 148),
                      ),
                      error: (error, _) => _InlineError(
                        message: 'Unable to load styles.',
                        onRetry: () =>
                            ref.invalidate(trendingTemplatesProvider),
                      ),
                      data: (trending) {
                        if (trending.isEmpty) {
                          return const Center(
                            child: Text('No trending styles yet.'),
                          );
                        }
                        return ListView.separated(
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
                              onTap: () =>
                                  context.push('/template/${template.id}'),
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
                ...templatesAsync.when(
                  loading: () => [
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _gridCount(context),
                        crossAxisSpacing: AppSpacing.cardGap,
                        mainAxisSpacing: AppSpacing.lg,
                        childAspectRatio: 0.68,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => const SkeletonCard(),
                        childCount: 4,
                      ),
                    ),
                  ],
                  error: (error, _) => [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: ErrorState(
                          title: 'Unable to load styles.',
                          message: 'Check your connection and try again.',
                          onRetry: () => ref.invalidate(templatesProvider),
                        ),
                      ),
                    ),
                  ],
                  data: (templates) {
                    final explore = query.isEmpty
                        ? templates
                        : templates
                            .where(
                              (t) =>
                                  t.name.toLowerCase().contains(query) ||
                                  t.category.toLowerCase().contains(query),
                            )
                            .toList(growable: false);

                    if (explore.isEmpty) {
                      return [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 48),
                            child: Text(
                              templates.isEmpty
                                  ? 'No styles available.'
                                  : 'No styles match your search.',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ];
                    }

                    return [
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
                              onTap: () =>
                                  context.push('/template/${template.id}'),
                            );
                          },
                          childCount: explore.length,
                        ),
                      ),
                    ];
                  },
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xxxl),
                ),
              ],
            ),
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

class _InlineError extends StatelessWidget {
  const _InlineError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
          TextButton(onPressed: onRetry, child: const Text('Try Again')),
        ],
      ),
    );
  }
}
