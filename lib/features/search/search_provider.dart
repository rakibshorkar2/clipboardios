import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../database/database.dart';
import 'package:drift/drift.dart';
import '../../services/clipboard_service.dart';
import '../../core/providers.dart';
import '../../models/clip_type.dart';

part 'search_provider.g.dart';

class SearchFilters {
  final ClipType? type;
  final bool? isFavorite;
  final bool? isPinned;
  final DateTime? startDate;

  SearchFilters({
    this.type,
    this.isFavorite,
    this.isPinned,
    this.startDate,
  });

  SearchFilters copyWith({
    ClipType? type,
    bool? isFavorite,
    bool? isPinned,
    DateTime? startDate,
  }) {
    return SearchFilters(
      type: type ?? this.type,
      isFavorite: isFavorite ?? this.isFavorite,
      isPinned: isPinned ?? this.isPinned,
      startDate: startDate ?? this.startDate,
    );
  }
}

@riverpod
class SearchFilter extends _$SearchFilter {
  @override
  SearchFilters build() => SearchFilters();

  void setType(ClipType? type) => state = state.copyWith(type: type);
  void setFavorite(bool? favorite) => state = state.copyWith(isFavorite: favorite);
  void setPinned(bool? pinned) => state = state.copyWith(isPinned: pinned);
  void setStartDate(DateTime? date) => state = state.copyWith(startDate: date);
  void clear() => state = SearchFilters();
}

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

@riverpod
Stream<List<ClipboardItem>> searchResults(SearchResultsRef ref) {
  final query = ref.watch(searchQueryProvider);
  final filters = ref.watch(searchFilterProvider);
  final db = ref.watch(appDatabaseProvider);

  var select = db.select(db.clipboardItems)
    ..where((t) => t.isDeleted.equals(false));

  if (query.isNotEmpty) {
    select.where((t) => 
        t.content.like('%$query%') | 
        t.note.like('%$query%') | 
        t.ocrText.like('%$query%'));
  }

  if (filters.type != null) {
    select.where((t) => t.type.equals(filters.type!.index));
  }
  if (filters.isFavorite != null) {
    select.where((t) => t.isFavorite.equals(filters.isFavorite!));
  }
  if (filters.isPinned != null) {
    select.where((t) => t.isPinned.equals(filters.isPinned!));
  }
  if (filters.startDate != null) {
    select.where((t) => t.createdAt.isBiggerThanValue(filters.startDate!));
  }

  select.orderBy([(t) => OrderingTerm(expression: t.lastCopiedAt, mode: OrderingMode.desc)]);
  
  return select.watch();
}
