import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../home/home_screen.dart';
import '../search/search_screen.dart';
import '../collections/collections_screen.dart';
import '../favorites/favorites_screen.dart';
import '../settings/settings_screen.dart';

part 'navigation_provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    initialLocation: '/',
    navigatorKey: rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
          GoRoute(path: '/collections', builder: (context, state) => const CollectionsScreen()),
          GoRoute(path: '/favorites', builder: (context, state) => const FavoritesScreen()),
          GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
        ],
      ),
    ],
  );
}

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    
    int getIndex() {
      if (location == '/') return 0;
      if (location == '/search') return 1;
      if (location == '/collections') return 2;
      if (location == '/favorites') return 3;
      if (location == '/settings') return 4;
      return 0;
    }

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: getIndex(),
        onTap: (index) {
          switch (index) {
            case 0: context.go('/'); break;
            case 1: context.go('/search'); break;
            case 2: context.go('/collections'); break;
            case 3: context.go('/favorites'); break;
            case 4: context.go('/settings'); break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.folder), label: 'Collections'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.star), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => child,
        );
      },
    );
  }
}
