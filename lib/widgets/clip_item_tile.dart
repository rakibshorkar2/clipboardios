import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../database/database.dart';
import '../models/clip_type.dart';
import 'package:drift/drift.dart' hide Column;
import '../services/clipboard_service.dart';
import '../core/providers.dart';

class ClipItemTile extends ConsumerWidget {
  final ClipboardItem item;
  const ClipItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoListTile.notched(
      title: Text(
        item.content.trim(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${item.type.name.toUpperCase()} • ${DateFormat.jm().format(item.lastCopiedAt)} • ${item.copyCount}x',
      ),
      leading: _getTypeIcon(item.type),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              item.isFavorite ? CupertinoIcons.star_fill : CupertinoIcons.star,
              color: item.isFavorite ? CupertinoColors.systemYellow : CupertinoColors.systemGrey,
              size: 20,
            ),
            onPressed: () => _toggleFavorite(ref),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              item.isPinned ? CupertinoIcons.pin_fill : CupertinoIcons.pin,
              color: item.isPinned ? CupertinoColors.systemOrange : CupertinoColors.systemGrey,
              size: 20,
            ),
            onPressed: () => _togglePinned(ref),
          ),
          const Icon(CupertinoIcons.chevron_right, color: CupertinoColors.systemGrey4, size: 14),
        ],
      ),
      onTap: () {
        // Show details
      },
    );
  }

  void _toggleFavorite(WidgetRef ref) {
    final db = ref.read(appDatabaseProvider);
    (db.update(db.clipboardItems)..where((t) => t.id.equals(item.id)))
        .write(ClipboardItemsCompanion(isFavorite: Value(!item.isFavorite)));
  }

  void _togglePinned(WidgetRef ref) {
    final db = ref.read(appDatabaseProvider);
    (db.update(db.clipboardItems)..where((t) => t.id.equals(item.id)))
        .write(ClipboardItemsCompanion(isPinned: Value(!item.isPinned)));
  }

  Widget _getTypeIcon(ClipType type) {
    IconData iconData;
    switch (type) {
      case ClipType.url: iconData = CupertinoIcons.link; break;
      case ClipType.image: iconData = CupertinoIcons.photo; break;
      case ClipType.email: iconData = CupertinoIcons.mail; break;
      case ClipType.phone: iconData = CupertinoIcons.phone; break;
      case ClipType.magnet: iconData = CupertinoIcons.bolt; break;
      case ClipType.password: iconData = CupertinoIcons.lock; break;
      case ClipType.json: iconData = CupertinoIcons.settings; break;
      case ClipType.code: iconData = CupertinoIcons.square_list; break;
      default: iconData = CupertinoIcons.doc_text;
    }
    return Icon(iconData, color: CupertinoColors.systemBlue);
  }
}
