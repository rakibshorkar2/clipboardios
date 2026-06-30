import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';
import 'clipboard_service.dart';
import 'package:drift/drift.dart';
import '../core/providers.dart';

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
    for (var item in totalItems) {
      typeCounts[item.type.name] = (typeCounts[item.type.name] ?? 0) + 1;
    }

    return {
      'totalSaved': totalItems.length,
      'mostCopiedContent': mostCopied.content,
      'mostCopiedCount': mostCopied.copyCount,
      'mostCommonType': typeCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key,
      'favoritesCount': totalItems.where((i) => i.isFavorite).length,
    };
  }
}
