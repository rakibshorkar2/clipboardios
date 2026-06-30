import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../database/database.dart';
import 'package:drift/drift.dart';
import '../../services/clipboard_service.dart';
import '../../core/providers.dart';

part 'search_provider.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

@riverpod
Stream<List<ClipboardItem>> searchResults(SearchResultsRef ref) {
  final query = ref.watch(searchQueryProvider);
  final db = ref.watch(appDatabaseProvider);

  if (query.isEmpty) {
    return (db.select(db.clipboardItems)
          ..orderBy([(t) => OrderingTerm(expression: t.lastCopiedAt, mode: OrderingMode.desc)]))
        .watch();
  }

  return (db.select(db.clipboardItems)
        ..where((t) => 
            t.content.like('%$query%') | 
            t.note.like('%$query%') | 
            t.ocrText.like('%$query%'))
        ..orderBy([(t) => OrderingTerm(expression: t.lastCopiedAt, mode: OrderingMode.desc)]))
      .watch();
}
