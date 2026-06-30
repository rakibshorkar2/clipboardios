import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';
import '../core/providers.dart';
import 'package:drift/drift.dart';

part 'stats_service.g.dart';

@riverpod
class StatsService extends _$StatsService {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    final db = ref.watch(appDatabaseProvider);
    
    final totalItems = await db.select(db.clipboardItems).get();
    if (totalItems.isEmpty) return {};

    final mostCopied = totalItems.reduce((a, b) => a.copyCount > b.copyCount ? a : b);
    
    final typeCounts = <String, int>{};
    final dayCounts = <String, int>{};
    int currentStreak = 0;
    int longestStreak = 0;
    DateTime? lastDate;

    // Sort by date for streak calculation
    final sortedItems = List<ClipboardItem>.from(totalItems)..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    for (var item in sortedItems) {
      typeCounts[item.type.name] = (typeCounts[item.type.name] ?? 0) + 1;
      
      final dateStr = item.createdAt.toIso8601String().split('T')[0];
      dayCounts[dateStr] = (dayCounts[dateStr] ?? 0) + 1;

      if (lastDate != null) {
        final diff = item.createdAt.difference(lastDate).inDays;
        if (diff == 1) {
          currentStreak++;
        } else if (diff > 1) {
          currentStreak = 1;
        }
        if (currentStreak > longestStreak) longestStreak = currentStreak;
      } else {
        currentStreak = 1;
        longestStreak = 1;
      }
      lastDate = item.createdAt;
    }

    final mostActiveDay = dayCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    return {
      'totalSaved': totalItems.length,
      'mostCopiedContent': mostCopied.content,
      'mostCopiedCount': mostCopied.copyCount,
      'mostCommonType': typeCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key,
      'favoritesCount': totalItems.where((i) => i.isFavorite).length,
      'mostActiveDay': mostActiveDay,
      'longestStreak': longestStreak,
    };
  }
}
