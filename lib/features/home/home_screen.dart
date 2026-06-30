import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' hide Column;
import '../../database/database.dart';
import '../../services/clipboard_service.dart';
import '../../models/clip_type.dart';

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
                  child: Center(child: Text('Your clipboard history is empty')),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = items[index];
                    return _ClipItemTile(item: item);
                  },
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

class _ClipItemTile extends StatelessWidget {
  final ClipboardItem item;
  const _ClipItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      title: Text(
        item.content.trim(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${item.type.name.toUpperCase()} • ${DateFormat.jm().format(item.lastCopiedAt)} • Copied ${item.copyCount}x',
      ),
      leading: _getTypeIcon(item.type),
      trailing: const CupertinoListTileChevron(),
      onTap: () {
        // Show details or copy back to clipboard
      },
    );
  }

  Widget _getTypeIcon(ClipType type) {
    IconData iconData;
    switch (type) {
      case ClipType.url: iconData = CupertinoIcons.link; break;
      case ClipType.image: iconData = CupertinoIcons.photo; break;
      case ClipType.email: iconData = CupertinoIcons.mail; break;
      case ClipType.phone: iconData = CupertinoIcons.phone; break;
      case ClipType.magnet: iconData = CupertinoIcons.bolt; break;
      default: iconData = CupertinoIcons.doc_text;
    }
    return Icon(iconData, color: CupertinoColors.systemBlue);
  }
}
