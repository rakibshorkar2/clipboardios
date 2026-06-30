import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../database/database.dart';
import '../../services/clipboard_service.dart';
import '../../widgets/clip_item_tile.dart';
import 'package:drift/drift.dart' hide Column;
import '../../core/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  ..where((t) => t.isDeleted.equals(false))
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

              final groupedItems = _groupItems(items);

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final entry = groupedItems[index];
                    if (entry is String) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Text(
                          entry.toUpperCase(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.secondaryLabel.resolveFrom(context),
                          ),
                        ),
                      );
                    } else {
                      return ClipItemTile(item: entry as ClipboardItem);
                    }
                  },
                  childCount: groupedItems.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<dynamic> _groupItems(List<ClipboardItem> items) {
    final grouped = <dynamic>[];
    String? currentGroup;

    for (final item in items) {
      if (item.isPinned) {
        if (currentGroup != 'Pinned') {
          currentGroup = 'Pinned';
          grouped.add('Pinned');
        }
      } else {
        final now = DateTime.now();
        final diff = now.difference(item.lastCopiedAt).inDays;
        String group;
        if (diff == 0) {
          group = 'Today';
        } else if (diff == 1) {
          group = 'Yesterday';
        } else {
          group = 'Older';
        }

        if (currentGroup != group) {
          currentGroup = group;
          grouped.add(group);
        }
      }
      grouped.add(item);
    }
    return grouped;
  }
}
