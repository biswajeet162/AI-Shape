import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/explore/presentation/explore_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/templates/presentation/template_detail_screen.dart';
import 'main_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                name: 'explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                name: 'history',
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/template/:id',
        name: 'template',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return TemplateDetailScreen(templateId: id);
        },
      ),
      GoRoute(
        path: '/photo/:templateId',
        name: 'photo',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => _PhasePlaceholder(
          title: 'Choose your photo',
          message: 'Camera and gallery selection arrive in Phase 3.',
          detail: state.pathParameters['templateId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/generate',
        name: 'generate',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const _PhasePlaceholder(
          title: 'Generate',
          message: 'AI generation arrives in Phase 4.',
        ),
      ),
      GoRoute(
        path: '/result/:generationId',
        name: 'result',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => _PhasePlaceholder(
          title: 'Result',
          message: 'Results arrive in Phase 4.',
          detail: state.pathParameters['generationId'] ?? '',
        ),
      ),
    ],
  );
});

class _PhasePlaceholder extends StatelessWidget {
  const _PhasePlaceholder({
    required this.title,
    required this.message,
    this.detail,
  });

  final String title;
  final String message;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              if (detail != null && detail!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  detail!,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
