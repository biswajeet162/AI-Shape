import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/explore/presentation/explore_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/home/presentation/home_screen.dart';
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
      // Placeholders for later phases — keep route contract ready.
      GoRoute(
        path: '/template/:id',
        name: 'template',
        builder: (context, state) => _PlaceholderRoute(
          title: 'Template',
          detail: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(
        path: '/photo/:templateId',
        name: 'photo',
        builder: (context, state) => _PlaceholderRoute(
          title: 'Choose Photo',
          detail: state.pathParameters['templateId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/generate',
        name: 'generate',
        builder: (context, state) => const _PlaceholderRoute(
          title: 'Generate',
          detail: 'Coming in Phase 4',
        ),
      ),
      GoRoute(
        path: '/result/:generationId',
        name: 'result',
        builder: (context, state) => _PlaceholderRoute(
          title: 'Result',
          detail: state.pathParameters['generationId'] ?? '',
        ),
      ),
    ],
  );
});

class _PlaceholderRoute extends StatelessWidget {
  const _PlaceholderRoute({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Center(
        child: Text(detail, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
