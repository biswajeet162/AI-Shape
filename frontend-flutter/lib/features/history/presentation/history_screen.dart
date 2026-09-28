import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/empty_error_states.dart';
import '../../../core/widgets/responsive_center.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: AppConstants.maxContentWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(
                title: 'History',
                subtitle: 'Your recent creations',
                showProfile: false,
              ),
              Expanded(
                child: EmptyState(
                  title: 'No creations yet.',
                  message: 'Choose a style and create your first AI photo.',
                  actionLabel: 'Explore Styles',
                  onAction: () => context.go('/explore'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
