import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';
import '../models/clip_type.dart';
import 'package:drift/drift.dart';
import 'metadata_service.dart';
import 'ocr_service.dart';
import '../core/providers.dart';

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
    
    final existing = await (db.select(db.clipboardItems)
          ..where((t) => t.contentHash.equals(hash)))
        .getSingleOrNull();

    if (existing != null) {
      await (db.update(db.clipboardItems)
            ..where((t) => t.id.equals(existing.id)))
          .write(ClipboardItemsCompanion(
            copyCount: Value(existing.copyCount + 1),
            lastCopiedAt: Value(DateTime.now()),
          ));
    } else {
      final type = detectType(text);
      final id = await db.into(db.clipboardItems).insert(ClipboardItemsCompanion.insert(
            content: text,
            normalizedContent: normalized,
            contentHash: hash,
            type: type,
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
            lastCopiedAt: Value(DateTime.now()),
            copyCount: const Value(1),
          ));
          
      // Secondary processing
      if (type == ClipType.url) {
        _processUrlMetadata(id, text);
      }
    }
  }

  Future<void> _processUrlMetadata(int id, String url) async {
    final metadata = await ref.read(metadataServiceProvider.notifier).fetchMetadata(url);
    if (metadata.isNotEmpty) {
      final db = ref.read(appDatabaseProvider);
      await (db.update(db.clipboardItems)..where((t) => t.id.equals(id)))
          .write(ClipboardItemsCompanion(
            metadata: Value(jsonEncode(metadata)),
          ));
    }
  }

  String _normalizeText(String text) {
    return text.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
  }

  String _generateHash(String text) {
    return sha256.convert(utf8.encode(text)).toString();
  }

  static ClipType detectType(String text) {
    if (text.startsWith('magnet:?xt=')) return ClipType.magnet;
    if (text.startsWith('torrent:')) return ClipType.torrent;
    
    final urlRegex = RegExp(r'^https?://[^\s]+$');
    if (urlRegex.hasMatch(text)) return ClipType.url;

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (emailRegex.hasMatch(text)) return ClipType.email;

    final phoneRegex = RegExp(r'^\+?[0-9\s\-()]{7,20}$');
    if (phoneRegex.hasMatch(text)) return ClipType.phone;

    if (text.length > 8 && 
        RegExp(r'[A-Z]').hasMatch(text) && 
        RegExp(r'[0-9]').hasMatch(text) && 
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(text)) {
      return ClipType.password;
    }

    if (RegExp(r'^(1|3|bc1)[a-zA-HJ-NP-Z0-9]{25,39}$').hasMatch(text)) return ClipType.code;

    try {
      final decoded = jsonDecode(text);
      if (decoded is Map || decoded is List) return ClipType.json;
    } catch (_) {}

    if (text.contains(RegExp(r'SELECT|INSERT|UPDATE|DELETE|CREATE|DROP', caseSensitive: false)) && text.contains('FROM')) return ClipType.code;
    if (text.contains(RegExp(r'fun |var |val |def |class |void |int |String '))) return ClipType.code;

    if (text.contains(RegExp(r'^#\s|\[.*\]\(.*\)', multiLine: true))) return ClipType.markdown;

    return ClipType.text;
  }
}
