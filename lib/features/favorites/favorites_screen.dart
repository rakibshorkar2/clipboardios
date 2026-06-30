import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';
import '../../services/clipboard_service.dart';
import '../../widgets/clip_item_tile.dart';
import 'package:drift/drift.dart' hide Column;
import '../../core/providers.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Favorites'),
          ),
          StreamBuilder<List<ClipboardItem>>(
            stream: (db.select(db.clipboardItems)
                  ..where((t) => t.isFavorite.equals(true))
                  ..orderBy([(t) => OrderingTerm(expression: t.lastCopiedAt, mode: OrderingMode.desc)]))
                .watch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(child: CupertinoActivityIndicator()),
                );
              }
              
              final items = snapshot.data ?? [];
              if (items.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('No favorites yet')),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ClipItemTile(item: items[index]),
                  childCount: items.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
