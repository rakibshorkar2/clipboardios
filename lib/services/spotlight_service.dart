import 'package:flutter_core_spotlight/flutter_core_spotlight.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';

part 'spotlight_service.g.dart';

@riverpod
class SpotlightService extends _$SpotlightService {
  @override
  void build() {}

  Future<void> indexItem(ClipboardItem item) async {
    try {
      final spotlightItem = FlutterSpotlightItem(
        uniqueIdentifier: item.id.toString(),
        domainIdentifier: 'com.clipvault.app',
        attributeTitle: item.content.length > 50 ? '${item.content.substring(0, 50)}...' : item.content,
        attributeDescription: '${item.type.name.toUpperCase()} • Copied ${item.copyCount} times',
      );
      await FlutterCoreSpotlight.instance.indexSearchableItems([spotlightItem]);
    } catch (e) {
      print("Spotlight indexing error: $e");
    }
  }

  Future<void> removeItem(int id) async {
    try {
      await FlutterCoreSpotlight.instance.deleteSearchableItems([id.toString()]);
    } catch (e) {
      print("Spotlight removal error: $e");
    }
  }
}
