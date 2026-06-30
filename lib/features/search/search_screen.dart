import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'search_provider.dart';
import '../../widgets/clip_item_tile.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchResultsProvider);
    
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Search'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoSearchTextField(
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).update(value);
                },
              ),
            ),
          ),
          results.when(
            data: (items) {
              if (items.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('No matches found')),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ClipItemTile(item: items[index]),
                  childCount: items.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CupertinoActivityIndicator()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
