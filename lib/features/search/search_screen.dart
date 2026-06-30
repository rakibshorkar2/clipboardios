import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'search_provider.dart';
import '../../widgets/clip_item_tile.dart';
import '../../models/clip_type.dart';

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CupertinoSearchTextField(
                    onChanged: (value) {
                      ref.read(searchQueryProvider.notifier).update(value);
                    },
                  ),
                ),
                const SearchFilterChips(),
              ],
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

class SearchFilterChips extends ConsumerWidget {
  const SearchFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(searchFilterProvider);
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _FilterChip(
            label: 'Favorites',
            isSelected: filters.isFavorite == true,
            onTap: () => ref.read(searchFilterProvider.notifier).setFavorite(filters.isFavorite == true ? null : true),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Pinned',
            isSelected: filters.isPinned == true,
            onTap: () => ref.read(searchFilterProvider.notifier).setPinned(filters.isPinned == true ? null : true),
          ),
          const SizedBox(width: 8),
          ...ClipType.values.take(6).map((type) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _FilterChip(
              label: type.name.toUpperCase(),
              isSelected: filters.type == type,
              onTap: () => ref.read(searchFilterProvider.notifier).setType(filters.type == type ? null : type),
            ),
          )),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? CupertinoColors.activeBlue : CupertinoColors.systemGrey5,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? CupertinoColors.white : CupertinoColors.label,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
