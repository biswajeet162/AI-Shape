import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/empty_error_states.dart';
import '../../../core/widgets/responsive_center.dart';
import 'template_providers.dart';

class TemplateDetailScreen extends ConsumerWidget {
  const TemplateDetailScreen({super.key, required this.templateId});

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTemplate = ref.watch(templateDetailProvider(templateId));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: asyncTemplate.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorState(
            title: 'Unable to load style',
            message: 'Please try again.',
            onRetry: () => ref.invalidate(templateDetailProvider(templateId)),
          ),
          data: (template) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      Semantics(
                        button: true,
                        label: 'Back',
                        child: IconButton(
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/home');
                            }
                          },
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  child: ResponsiveCenter(
                    maxWidth: AppConstants.maxContentWidth,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 3 / 4,
                            child: ClipRRect(
                              borderRadius: AppRadius.imageAll,
                              child: CachedNetworkImage(
                                imageUrl: template.thumbnailUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) => const ColoredBox(
                                  color: AppColors.shimmerBase,
                                ),
                                errorWidget: (context, url, error) =>
                                    const ColoredBox(
                                  color: AppColors.surfaceMuted,
                                  child: Icon(
                                    Icons.image_outlined,
                                    size: 48,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(duration: 350.ms)
                              .scale(
                                begin: const Offset(0.98, 0.98),
                                end: const Offset(1, 1),
                                duration: 350.ms,
                              ),
                          const SizedBox(height: AppSpacing.xl),
                          Text(template.name, style: textTheme.displayMedium),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            template.category,
                            style: textTheme.labelMedium?.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            template.description,
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: ResponsiveCenter(
                    maxWidth: AppConstants.maxContentWidth,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        AppSpacing.sm,
                        0,
                        AppSpacing.md,
                      ),
                      child: PrimaryButton(
                        label: 'Try This Style',
                        icon: Icons.auto_awesome_rounded,
                        onPressed: () =>
                            context.push('/photo/${template.id}'),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
