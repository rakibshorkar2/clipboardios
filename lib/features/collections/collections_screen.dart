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
            trailing: Icon(CupertinoIcons.add),
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
          const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(16), child: Text('Tags', style: TextStyle(fontWeight: FontWeight.bold)))),
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
}
