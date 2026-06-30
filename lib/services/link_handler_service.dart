import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';
import '../models/clip_type.dart';
import 'package:drift/drift.dart';
import 'clipboard_service.dart';
import 'metadata_service.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../core/providers.dart';

part 'link_handler_service.g.dart';

@riverpod
class LinkHandlerService extends _$LinkHandlerService {
  StreamSubscription? _intentDataStreamSubscription;
  late final AppLinks _appLinks;

  @override
  void build() {
    _appLinks = AppLinks();
    ref.onDispose(() => _intentDataStreamSubscription?.cancel());
    
    _intentDataStreamSubscription = ReceiveSharingIntent.instance.getMediaStream().listen((List<SharedMediaFile> value) {
      for (var file in value) {
        if (file.type == SharedMediaType.text || file.type == SharedMediaType.url) {
          _handleIncomingText(file.path);
        }
      }
    }, onError: (err) {
      print("getMediaStream error: $err");
    });

    ReceiveSharingIntent.instance.getInitialMedia().then((List<SharedMediaFile> value) {
      for (var file in value) {
        if (file.type == SharedMediaType.text || file.type == SharedMediaType.url) {
          _handleIncomingText(file.path);
        }
      }
    });

    _appLinks.allUriLinkStream.listen((uri) {
      _handleIncomingText(uri.toString());
    });
  }

  Future<void> _handleIncomingText(String text) async {
    if (text.isEmpty) return;

    final db = ref.read(appDatabaseProvider);
    final normalized = text.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
    final hash = sha256.convert(utf8.encode(normalized)).toString();

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
      final type = ClipboardService.detectType(text);
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
}
