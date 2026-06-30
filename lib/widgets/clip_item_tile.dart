import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
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
    return CupertinoContextMenu(
      actions: _buildContextActions(context, ref),
      child: CupertinoListTile.notched(
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
          ],
        ),
        onTap: () {
          Clipboard.setData(ClipboardData(text: item.content));
          HapticFeedback.mediumImpact();
        },
      ),
    );
  }

  List<Widget> _buildContextActions(BuildContext context, WidgetRef ref) {
    final actions = <Widget>[
      CupertinoContextMenuAction(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: item.content));
          Navigator.pop(context);
        },
        trailingIcon: CupertinoIcons.doc_on_doc,
        child: const Text('Copy'),
      ),
      CupertinoContextMenuAction(
        onPressed: () => _toggleFavorite(ref, context),
        trailingIcon: item.isFavorite ? CupertinoIcons.star_fill : CupertinoIcons.star,
        child: Text(item.isFavorite ? 'Unfavorite' : 'Favorite'),
      ),
      CupertinoContextMenuAction(
        onPressed: () => _togglePinned(ref, context),
        trailingIcon: item.isPinned ? CupertinoIcons.pin_slash : CupertinoIcons.pin,
        child: Text(item.isPinned ? 'Unpin' : 'Pin'),
      ),
      CupertinoContextMenuAction(
        onPressed: () => _showAssignCollection(context, ref),
        trailingIcon: CupertinoIcons.folder_badge_plus,
        child: const Text('Add to Collection'),
      ),
      CupertinoContextMenuAction(
        onPressed: () => _showAddTag(context, ref),
        trailingIcon: CupertinoIcons.tag,
        child: const Text('Add Tag'),
      ),
    ];

    switch (item.type) {
      case ClipType.url:
      case ClipType.magnet:
        actions.add(
          CupertinoContextMenuAction(
            onPressed: () => launchUrl(Uri.parse(item.content)),
            trailingIcon: CupertinoIcons.arrow_up_right_circle,
            child: const Text('Open Link'),
          ),
        );
        break;
      case ClipType.phone:
        actions.add(
          CupertinoContextMenuAction(
            onPressed: () => launchUrl(Uri.parse('tel:${item.content}')),
            trailingIcon: CupertinoIcons.phone,
            child: const Text('Call Number'),
          ),
        );
        break;
      case ClipType.email:
        actions.add(
          CupertinoContextMenuAction(
            onPressed: () => launchUrl(Uri.parse('mailto:${item.content}')),
            trailingIcon: CupertinoIcons.mail,
            child: const Text('Send Email'),
          ),
        );
        break;
      default:
        break;
    }

    actions.add(
      CupertinoContextMenuAction(
        isDestructiveAction: true,
        onPressed: () {
          final db = ref.read(appDatabaseProvider);
          (db.update(db.clipboardItems)..where((t) => t.id.equals(item.id)))
              .write(ClipboardItemsCompanion(
                isDeleted: const Value(true),
                deletedAt: Value(DateTime.now()),
              ));
          HapticFeedback.mediumImpact();
          Navigator.pop(context);
        },
        trailingIcon: CupertinoIcons.delete,
        child: const Text('Move to Trash'),
      ),
    );

    return actions;
  }

  void _toggleFavorite(WidgetRef ref, [BuildContext? context]) {
    final db = ref.read(appDatabaseProvider);
    (db.update(db.clipboardItems)..where((t) => t.id.equals(item.id)))
        .write(ClipboardItemsCompanion(isFavorite: Value(!item.isFavorite)));
    HapticFeedback.lightImpact();
    if (context != null) Navigator.pop(context);
  }

  void _togglePinned(WidgetRef ref, [BuildContext? context]) {
    final db = ref.read(appDatabaseProvider);
    (db.update(db.clipboardItems)..where((t) => t.id.equals(item.id)))
        .write(ClipboardItemsCompanion(isPinned: Value(!item.isPinned)));
    HapticFeedback.lightImpact();
    if (context != null) Navigator.pop(context);
  }

  void _showAssignCollection(BuildContext context, WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);
    final collections = await db.select(db.collections).get();
    
    if (context.mounted) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: const Text('Add to Collection'),
          actions: collections.map((c) => CupertinoActionSheetAction(
            onPressed: () async {
              await db.into(db.itemCollections).insert(ItemCollectionsCompanion.insert(
                itemId: item.id,
                collectionId: c.id,
              ));
              Navigator.pop(context);
            },
            child: Text(c.name),
          )).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ),
      );
    }
  }

  void _showAddTag(BuildContext context, WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);
    final tags = await db.select(db.tags).get();
    
    if (context.mounted) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: const Text('Add Tag'),
          actions: tags.map((t) => CupertinoActionSheetAction(
            onPressed: () async {
              await db.into(db.itemTags).insert(ItemTagsCompanion.insert(
                itemId: item.id,
                tagId: t.id,
              ));
              Navigator.pop(context);
            },
            child: Text(t.name),
          )).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ),
      );
    }
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
      case ClipType.otp: iconData = CupertinoIcons.number; break;
      default: iconData = CupertinoIcons.doc_text;
    }
    return Icon(iconData, color: CupertinoColors.systemBlue);
  }
}
