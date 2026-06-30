import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';
import '../core/providers.dart';
import 'package:drift/drift.dart';

part 'home_widget_service.g.dart';

@riverpod
class HomeWidgetService extends _$HomeWidgetService {
  @override
  void build() {}

  Future<void> updateWidget() async {
    final db = ref.read(appDatabaseProvider);
    final recentItem = await (db.select(db.clipboardItems)
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.lastCopiedAt, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    if (recentItem != null) {
      await HomeWidget.saveWidgetData<String>('recent_clip', recentItem.content);
      await HomeWidget.updateWidget(
        iOSName: 'ClipVaultWidget',
      );
    }
  }
}
