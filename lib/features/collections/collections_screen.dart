import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';
import '../../services/clipboard_service.dart';
import '../../core/providers.dart';

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Collections'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton.filled(
                child: const Text('Add Collection'),
                onPressed: () => _showAddCollectionDialog(context, ref),
              ),
            ),
          ),
          StreamBuilder<List<Collection>>(
            stream: db.select(db.collections).watch(),
            builder: (context, snapshot) {
              final collections = snapshot.data ?? [];
              if (collections.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('Create collections to organize clips')),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CupertinoListTile.notched(
                    title: Text(collections[index].name),
                    leading: const Icon(CupertinoIcons.folder, color: CupertinoColors.systemBlue),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  childCount: collections.length,
                ),
              );
            },
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
              child: Text('Tags', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoButton(
                color: CupertinoColors.systemGrey5,
                child: const Text('Add Tag', style: TextStyle(color: CupertinoColors.activeBlue)),
                onPressed: () => _showAddTagDialog(context, ref),
              ),
            ),
          ),
          StreamBuilder<List<Tag>>(
            stream: db.select(db.tags).watch(),
            builder: (context, snapshot) {
              final tags = snapshot.data ?? [];
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text('#${tags[index].name}'),
                    ),
                  ),
                  childCount: tags.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddCollectionDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('New Collection'),
        content: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: CupertinoTextField(controller: controller, placeholder: 'Collection Name'),
        ),
        actions: [
          CupertinoDialogAction(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          CupertinoDialogAction(
            child: const Text('Create'),
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final db = ref.read(appDatabaseProvider);
                await db.into(db.collections).insert(CollectionsCompanion.insert(name: controller.text));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAddTagDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('New Tag'),
        content: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: CupertinoTextField(controller: controller, placeholder: 'Tag Name'),
        ),
        actions: [
          CupertinoDialogAction(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          CupertinoDialogAction(
            child: const Text('Create'),
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final db = ref.read(appDatabaseProvider);
                await db.into(db.tags).insert(TagsCompanion.insert(name: controller.text));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
