import 'package:quick_actions/quick_actions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import '../features/navigation/navigation_provider.dart';

part 'quick_actions_service.g.dart';

@riverpod
class QuickActionsService extends _$QuickActionsService {
  final QuickActions _quickActions = const QuickActions();

  @override
  void build() {
    _quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'action_search', localizedTitle: 'Search', icon: 'search'),
      const ShortcutItem(type: 'action_favorites', localizedTitle: 'Favorites', icon: 'star'),
      const ShortcutItem(type: 'action_new_note', localizedTitle: 'New Note', icon: 'add'),
    ]);

    _quickActions.initialize((shortcutType) {
      final router = ref.read(routerProvider);
      if (shortcutType == 'action_search') {
        router.go('/search');
      } else if (shortcutType == 'action_favorites') {
        router.go('/favorites');
      } else if (shortcutType == 'action_new_note') {
        // Implement new note screen or just go home
        router.go('/');
      }
    });
  }
}
