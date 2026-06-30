import 'dart:convert';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import '../database/database.dart';
import 'auth_service.dart';
import 'encryption_service.dart';
import 'package:drift/drift.dart';
import 'clipboard_service.dart';
import 'notification_service.dart';
import '../core/providers.dart';

part 'sync_service.g.dart';

@riverpod
class SyncService extends _$SyncService {
  @override
  FutureOr<void> build() async {
    // Initial sync check
  }

  Future<void> sync() async {
    final auth = ref.read(authServiceProvider.notifier);
    final user = await auth.signIn();
    if (user == null) return;

    final scopes = [drive.DriveApi.driveAppdataScope];
    final authResult = await user.authorizationClient.authorizeScopes(scopes);
    
    if (authResult == null) return;
    
    final client = authResult.authClient(scopes: scopes);

    final driveApi = drive.DriveApi(client);
    final db = ref.read(appDatabaseProvider);
    final encryption = ref.read(encryptionServiceProvider.notifier);

    // 1. Get unsynced items
    final unsynced = await (db.select(db.clipboardItems)
          ..where((t) => t.isSynced.equals(false)))
        .get();

    if (unsynced.isEmpty) return;

    // 2. Encrypt and Upload
    for (final item in unsynced) {
      await _uploadItem(driveApi, db, encryption, item);
    }

    // 4. Download new items from remote
    await _downloadRemoteItems(driveApi, db, encryption);
    
    ref.read(notificationServiceProvider.notifier).showNotification(
      'Sync Complete',
      'All your clips are safely backed up to Google Drive.',
    );
  }

  Future<void> _uploadItem(drive.DriveApi driveApi, AppDatabase db, EncryptionService encryption, ClipboardItem item) async {
    final payload = {
      'content': item.content,
      'normalizedContent': item.normalizedContent,
      'contentHash': item.contentHash,
      'type': item.type.index,
      'createdAt': item.createdAt.toIso8601String(),
      'updatedAt': item.updatedAt.toIso8601String(),
      'metadata': item.metadata,
      'ocrText': item.ocrText,
      'note': item.note,
      'copyCount': item.copyCount,
      'isFavorite': item.isFavorite,
      'isPinned': item.isPinned,
    };

    final encryptedPayload = await encryption.encryptData(jsonEncode(payload));
    
    final file = drive.File();
    file.name = 'item_${item.contentHash}.json';
    file.parents = ['appDataFolder'];

    final media = drive.Media(
      Stream.value(utf8.encode(encryptedPayload)),
      encryptedPayload.length,
    );

    try {
      final result = await driveApi.files.create(file, uploadMedia: media);
      await (db.update(db.clipboardItems)
            ..where((t) => t.id.equals(item.id)))
          .write(ClipboardItemsCompanion(
            isSynced: const Value(true),
            remoteId: Value(result.id),
          ));
    } catch (e) {
      print("Upload error for item ${item.id}: $e");
    }
  }

  Future<void> _downloadRemoteItems(drive.DriveApi driveApi, AppDatabase db, EncryptionService encryption) async {
    try {
      final fileList = await driveApi.files.list(
        spaces: 'appDataFolder',
        $fields: 'files(id, name, modifiedTime)',
      );

      if (fileList.files == null) return;

      for (final remoteFile in fileList.files!) {
        if (!remoteFile.name!.startsWith('item_')) continue;

        final hash = remoteFile.name!.replaceFirst('item_', '').replaceFirst('.json', '');
        
        final local = await (db.select(db.clipboardItems)
              ..where((t) => t.contentHash.equals(hash)))
            .getSingleOrNull();

        if (local == null) {
          // Download and insert
          final media = await driveApi.files.get(remoteFile.id!, downloadOptions: drive.DownloadOptions.metadata) as drive.Media;
          final List<int> data = [];
          await for (final chunk in media.stream) {
            data.addAll(chunk);
          }
          
          final encryptedPayload = utf8.decode(data);
          final decryptedPayload = await encryption.decryptData(encryptedPayload);
          final payload = jsonDecode(decryptedPayload);

          await db.into(db.clipboardItems).insert(ClipboardItemsCompanion.insert(
            content: payload['content'],
            normalizedContent: payload['normalizedContent'],
            contentHash: payload['contentHash'],
            type: ClipType.values[payload['type']],
            createdAt: Value(DateTime.parse(payload['createdAt'])),
            updatedAt: Value(DateTime.parse(payload['updatedAt'])),
            lastCopiedAt: Value(DateTime.parse(payload['updatedAt'])),
            metadata: Value(payload['metadata']),
            ocrText: Value(payload['ocrText']),
            note: Value(payload['note']),
            copyCount: Value(payload['copyCount'] ?? 1),
            isFavorite: Value(payload['isFavorite'] ?? false),
            isPinned: Value(payload['isPinned'] ?? false),
            isSynced: const Value(true),
            remoteId: Value(remoteFile.id),
          ));
        }
      }
    } catch (e) {
      print("Download error: $e");
    }
  }
}
