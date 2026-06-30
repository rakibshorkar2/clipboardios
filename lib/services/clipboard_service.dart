import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';
import '../models/clip_type.dart';
import 'package:drift/drift.dart';

part 'clipboard_service.g.dart';

@riverpod
class ClipboardService extends _$ClipboardService {
  Timer? _timer;
  String? _lastHash;

  @override
  void build() {
    ref.onDispose(() => _timer?.cancel());
    startMonitoring();
  }

  void startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      await _checkClipboard();
    });
  }

  Future<void> _checkClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;

    if (text == null || text.isEmpty) return;

    final normalized = _normalizeText(text);
    final hash = _generateHash(normalized);

    if (hash == _lastHash) return;
    _lastHash = hash;

    final db = ref.read(appDatabaseProvider);
    
    // Check if duplicate in DB
    final existing = await (db.select(db.clipboardItems)
          ..where((t) => t.contentHash.equals(hash)))
        .getSingleOrNull();

    if (existing != null) {
      // Update counter and last copied date
      await (db.update(db.clipboardItems)
            ..where((t) => t.id.equals(existing.id)))
          .write(ClipboardItemsCompanion(
            copyCount: Value(existing.copyCount + 1),
            lastCopiedAt: Value(DateTime.now()),
          ));
    } else {
      // Create new entry
      final type = _detectType(text);
      await db.into(db.clipboardItems).insert(ClipboardItemsCompanion.insert(
            content: text,
            normalizedContent: normalized,
            contentHash: hash,
            type: type,
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
            lastCopiedAt: Value(DateTime.now()),
            copyCount: const Value(1),
          ));
    }
  }

  String _normalizeText(String text) {
    // Ignore whitespace differences, line ending differences, and capitalization (optional in PRD)
    return text.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
  }

  String _generateHash(String text) {
    return sha256.convert(utf8.encode(text)).toString();
  }

  ClipType _detectType(String text) {
    if (text.startsWith('magnet:?xt=')) return ClipType.magnet;
    if (RegExp(r'^https?://[^\s]+$').hasMatch(text)) return ClipType.url;
    if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(text)) return ClipType.email;
    if (RegExp(r'^\+?[0-9\s\-()]{7,20}$').hasMatch(text)) return ClipType.phone;
    
    // Simple JSON check
    try {
      jsonDecode(text);
      return ClipType.json;
    } catch (_) {}

    // Simple Markdown check (presence of headers or links)
    if (text.contains(RegExp(r'^#\s|\[.*\]\(.*\)', multiLine: true))) return ClipType.markdown;

    return ClipType.text;
  }
}

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  return AppDatabase();
}
