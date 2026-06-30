import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../database/database.dart';
import '../models/clip_type.dart';
import 'package:drift/drift.dart';
import 'metadata_service.dart';
import 'ocr_service.dart';
import 'home_widget_service.dart';
import 'spotlight_service.dart';
import 'live_activity_service.dart';
import '../core/providers.dart';

part 'clipboard_service.g.dart';

@riverpod
class ClipboardService extends _$ClipboardService {
  Timer? _timer;
  Timer? _cleanupTimer;
  String? _lastHash;

  @override
  void build() {
    ref.onDispose(() {
      _timer?.cancel();
      _cleanupTimer?.cancel();
    });
    startMonitoring();
    startCleanup();
  }

  void startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      await _checkClipboard();
    });
  }

  void startCleanup() {
    // Run cleanup once a day
    _cleanupTimer = Timer.periodic(const Duration(hours: 24), (timer) async {
      await _cleanupTrash();
    });
  }

  Future<void> _checkClipboard() async {
    // Check for image first
    final imageBytes = await Pasteboard.image;
    if (imageBytes != null) {
      final hash = _generateHash(base64Encode(imageBytes).substring(0, 1000)); // Sample hash for images
      if (hash == _lastHash) return;
      _lastHash = hash;
      await _saveImage(imageBytes, hash);
      return;
    }

    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;

    if (text == null || text.isEmpty) return;

    final normalized = _normalizeText(text);
    final hash = _generateHash(normalized);

    if (hash == _lastHash) return;
    _lastHash = hash;

    final db = ref.read(appDatabaseProvider);
    
    final existing = await (db.select(db.clipboardItems)
          ..where((t) => t.contentHash.equals(hash) & t.isDeleted.equals(false)))
        .getSingleOrNull();

    if (existing != null) {
      await (db.update(db.clipboardItems)
            ..where((t) => t.id.equals(existing.id)))
          .write(ClipboardItemsCompanion(
            copyCount: Value(existing.copyCount + 1),
            lastCopiedAt: Value(DateTime.now()),
            isDeleted: const Value(false),
          ));
      HapticFeedback.selectionClick();
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
      
      HapticFeedback.lightImpact();

      if (type == ClipType.url) {
        _processUrlMetadata(id, text);
      }
      
      final newItem = await (db.select(db.clipboardItems)..where((t) => t.id.equals(id))).getSingle();
      ref.read(spotlightServiceProvider.notifier).indexItem(newItem);
      ref.read(liveActivityServiceProvider.notifier).startActivity('New Image Saved');
      ref.read(homeWidgetServiceProvider.notifier).updateWidget();
    }
  }
  Future<void> _saveImage(Uint8List bytes, String hash) async {
    final db = ref.read(appDatabaseProvider);
    
    final existing = await (db.select(db.clipboardItems)
          ..where((t) => t.contentHash.equals(hash) & t.isDeleted.equals(false)))
        .getSingleOrNull();

    if (existing != null) {
      await (db.update(db.clipboardItems)
            ..where((t) => t.id.equals(existing.id)))
          .write(ClipboardItemsCompanion(
            copyCount: Value(existing.copyCount + 1),
            lastCopiedAt: Value(DateTime.now()),
          ));
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final imagePath = p.join(dir.path, 'images', '$hash.png');
      final file = File(imagePath);
      await file.parent.create(recursive: true);
      await file.writeAsBytes(bytes);

      final id = await db.into(db.clipboardItems).insert(ClipboardItemsCompanion.insert(
            content: 'Image item',
            normalizedContent: 'image',
            contentHash: hash,
            type: ClipType.image,
            imagePath: Value(imagePath),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
            lastCopiedAt: Value(DateTime.now()),
            copyCount: const Value(1),
          ));
      
      HapticFeedback.lightImpact();
      _processImageOcr(id, imagePath);
      
      final newItem = await (db.select(db.clipboardItems)..where((t) => t.id.equals(id))).getSingle();
      ref.read(spotlightServiceProvider.notifier).indexItem(newItem);
      ref.read(liveActivityServiceProvider.notifier).startActivity('New Image Saved');
      ref.read(homeWidgetServiceProvider.notifier).updateWidget();
    }
  }

  Future<void> _processImageOcr(int id, String path) async {
    final text = await ref.read(ocrServiceProvider.notifier).recognizeText(path);
    if (text != null && text.isNotEmpty) {
      final db = ref.read(appDatabaseProvider);
      await (db.update(db.clipboardItems)..where((t) => t.id.equals(id)))
          .write(ClipboardItemsCompanion(
            ocrText: Value(text),
          ));
    }
  }

  Future<void> _cleanupTrash() async {
    final db = ref.read(appDatabaseProvider);
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    
    await (db.delete(db.clipboardItems)
          ..where((t) => t.isDeleted.equals(true) & t.deletedAt.isSmallerThanValue(thirtyDaysAgo)))
        .go();
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
    
    final urlRegex = RegExp(r'^https?://\S+$');
    if (urlRegex.hasMatch(text)) return ClipType.url;

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (emailRegex.hasMatch(text)) return ClipType.email;

    final phoneRegex = RegExp(r'^\+?[0-9\s\-()]{7,20}$');
    if (phoneRegex.hasMatch(text)) return ClipType.phone;

    if (RegExp(r'^-?\d+(\.\d+)?,\s*-?\d+(\.\d+)?$').hasMatch(text)) return ClipType.address;
    
    // IBAN / Bank Account (Basic)
    if (RegExp(r'^[A-Z]{2}\d{2}[A-Z0-9]{11,30}$').hasMatch(text)) return ClipType.code;
    
    // OTP
    if (RegExp(r'^\d{4,8}$').hasMatch(text)) return ClipType.otp;

    // Password
    if (text.length > 8 && 
        RegExp(r'[A-Z]').hasMatch(text) && 
        RegExp(r'[a-z]').hasMatch(text) && 
        RegExp(r'[0-9]').hasMatch(text) && 
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(text)) {
      return ClipType.password;
    }

    // Crypto
    if (RegExp(r'^(1|3|bc1)[a-zA-HJ-NP-Z0-9]{25,39}$').hasMatch(text)) return ClipType.code;
    if (RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(text)) return ClipType.code;

    // JSON
    try {
      final decoded = jsonDecode(text);
      if (decoded is Map || decoded is List) return ClipType.json;
    } catch (_) {}

    // Markdown
    if (text.contains(RegExp(r'^#\s|\[.*\]\(.*\)|^\s*-\s|^\s*\*\s', multiLine: true))) return ClipType.markdown;

    // SQL
    if (text.toUpperCase().contains(RegExp(r'\b(SELECT|INSERT|UPDATE|DELETE|CREATE|DROP|ALTER|FROM|WHERE)\b'))) return ClipType.code;

    return ClipType.text;
  }
}
