import 'dart:convert';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import '../database/database.dart';
import 'auth_service.dart';
import 'encryption_service.dart';
import 'package:drift/drift.dart';
import 'clipboard_service.dart';

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
      final payload = {
        'content': item.content,
        'type': item.type.index,
        'createdAt': item.createdAt.toIso8601String(),
        'updatedAt': item.updatedAt.toIso8601String(),
        'metadata': item.metadata,
        'ocrText': item.ocrText,
        'note': item.note,
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
        
        // 3. Mark as synced
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
  }
}
