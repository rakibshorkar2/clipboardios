import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';
import 'clipboard_service.dart';
import 'package:share_plus/share_plus.dart';
import '../core/providers.dart';

part 'export_service.g.dart';

@riverpod
class ExportService extends _$ExportService {
  @override
  void build() {}

  Future<void> exportToJson() async {
    final db = ref.read(appDatabaseProvider);
    final items = await db.select(db.clipboardItems).get();
    
    final data = items.map((item) => {
      'content': item.content,
      'type': item.type.name,
      'createdAt': item.createdAt.toIso8601String(),
      'copyCount': item.copyCount,
      'isFavorite': item.isFavorite,
      'isPinned': item.isPinned,
      'note': item.note,
    }).toList();

    final jsonString = jsonEncode(data);
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/clipvault_export.json');
    await file.writeAsString(jsonString);

    await Share.shareXFiles([XFile(file.path)], text: 'ClipVault Export');
  }

  Future<void> exportToCsv() async {
    final db = ref.read(appDatabaseProvider);
    final items = await db.select(db.clipboardItems).get();
    
    final buffer = StringBuffer();
    buffer.writeln('Content,Type,CreatedAt,CopyCount,IsFavorite,IsPinned,Note');
    
    for (var item in items) {
      final sanitizedContent = item.content.replaceAll('"', '""').replaceAll('\n', ' ');
      buffer.writeln('"$sanitizedContent",${item.type.name},${item.createdAt},${item.copyCount},${item.isFavorite},${item.isPinned},"${item.note ?? ''}"');
    }

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/clipvault_export.csv');
    await file.writeAsString(buffer.toString());

    await Share.shareXFiles([XFile(file.path)], text: 'ClipVault Export');
  }

  Future<void> importFromJson(String jsonPath) async {
    try {
      final file = File(jsonPath);
      final jsonString = await file.readAsString();
      final List<dynamic> data = jsonDecode(jsonString);
      
      final db = ref.read(appDatabaseProvider);
      for (var entry in data) {
        final content = entry['content'] as String;
        final normalized = content.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
        
        await db.into(db.clipboardItems).insert(ClipboardItemsCompanion.insert(
          content: content,
          normalizedContent: normalized,
          contentHash: 'imported_${DateTime.now().millisecondsSinceEpoch}_${content.hashCode}',
          type: ClipType.values.firstWhere((e) => e.name == entry['type'], orElse: () => ClipType.text),
          createdAt: Value(DateTime.parse(entry['createdAt'])),
          updatedAt: Value(DateTime.now()),
          lastCopiedAt: Value(DateTime.now()),
          note: Value(entry['note']),
        ));
      }
    } catch (e) {
      print("Import error: $e");
    }
  }
}
