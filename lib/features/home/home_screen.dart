import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';
import '../../services/clipboard_service.dart';
import '../../widgets/clip_item_tile.dart';
import 'package:drift/drift.dart' hide Column;
import '../../core/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Start clipboard monitoring
    ref.watch(clipboardServiceProvider);
    final db = ref.watch(appDatabaseProvider);
    
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Timeline'),
          ),
          StreamBuilder<List<ClipboardItem>>(
            stream: (db.select(db.clipboardItems)
                  ..orderBy([
                    (t) => OrderingTerm(expression: t.isPinned, mode: OrderingMode.desc),
                    (t) => OrderingTerm(expression: t.lastCopiedAt, mode: OrderingMode.desc),
                  ]))
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
                  child: Center(child: Text('Your clipboard history is empty')),
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
