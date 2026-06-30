import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';
import '../models/clip_type.dart';
import 'package:drift/drift.dart';
import 'clipboard_service.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

part 'link_handler_service.g.dart';

@riverpod
class LinkHandlerService extends _$LinkHandlerService {
  StreamSubscription? _intentDataStreamSubscription;

  @override
  void build() {
    ref.onDispose(() => _intentDataStreamSubscription?.cancel());
    
    // For sharing or opening URLs while the app is running
    _intentDataStreamSubscription = ReceiveSharingIntent.instance.getMediaStream().listen((List<SharedMediaFile> value) {
      for (var file in value) {
        if (file.type == SharedMediaType.text || file.type == SharedMediaType.url) {
          _handleIncomingText(file.path);
        }
      }
    }, onError: (err) {
      print("getMediaStream error: $err");
    });

    // For sharing or opening URLs when the app is closed
    ReceiveSharingIntent.instance.getInitialMedia().then((List<SharedMediaFile> value) {
      for (var file in value) {
        if (file.type == SharedMediaType.text || file.type == SharedMediaType.url) {
          _handleIncomingText(file.path);
        }
      }
    });
  }

  Future<void> _handleIncomingText(String text) async {
    if (text.isEmpty) return;

    final db = ref.read(appDatabaseProvider);
    final normalized = text.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
    final hash = sha256.convert(utf8.encode(normalized)).toString();

    // Check if duplicate
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

  ClipType _detectType(String text) {
    if (text.startsWith('magnet:?xt=')) return ClipType.magnet;
    if (RegExp(r'^https?://[^\s]+$').hasMatch(text)) return ClipType.url;
    return ClipType.text;
  }
}
