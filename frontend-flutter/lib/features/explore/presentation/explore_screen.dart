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
    final query = ref.watch(exploreSearchQueryProvider);
    final category = ref.watch(exploreCategoryProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final templatesAsync = ref.watch(
      exploreTemplatesProvider((category: category, query: query)),
    );

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
                child: categoriesAsync.when(
                  loading: () => ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: AppSpacing.xs),
                    itemBuilder: (context, index) => Container(
                      width: 72,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  error: (error, stackTrace) => CategoryChip(
                    label: 'All',
                    selected: true,
                    onSelected: (_) {},
                  ),
                  data: (categories) {
                    final labels = [
                      'All',
                      ...categories.map((c) => c.name),
                    ];
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: labels.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: AppSpacing.xs),
                      itemBuilder: (context, index) {
                        final label = labels[index];
                        return CategoryChip(
                          label: label,
                          selected: category == label,
                          onSelected: (_) {
                            ref
                                .read(exploreCategoryProvider.notifier)
                                .select(label);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(categoriesProvider);
                    ref.invalidate(
                      exploreTemplatesProvider((category: category, query: query)),
                    );
                    await ref.read(
                      exploreTemplatesProvider((category: category, query: query))
                          .future,
                    );
                  },
                  child: templatesAsync.when(
                    loading: () => TemplateGrid(
                      itemCount: 6,
                      itemBuilder: (context, index) => const SkeletonCard(),
                    ),
                    error: (error, _) => ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.45,
                          child: ErrorState(
                            title: 'Unable to load styles.',
                            message: 'Check your connection and try again.',
                            onRetry: () {
                              ref.invalidate(
                                exploreTemplatesProvider(
                                  (category: category, query: query),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    data: (filtered) {
                      if (filtered.isEmpty) {
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.45,
                              child: const EmptyState(
                                title: 'No styles available.',
                                message: 'Try another category or search.',
                                icon: Icons.search_off_rounded,
                              ),
                            ),
                          ],
                        );
                      }

                      return TemplateGrid(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final template = filtered[index];
                          return TemplateCard(
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
            ],
          ),
        ),
      ),
    );
  }
}
