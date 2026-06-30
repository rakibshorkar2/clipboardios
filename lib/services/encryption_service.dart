import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

part 'encryption_service.g.dart';

@riverpod
class EncryptionService extends _$EncryptionService {
  static const _storage = FlutterSecureStorage();
  static const _keyAlias = 'clipvault_encryption_key';

  @override
  FutureOr<void> build() {}

  Future<String> _getOrCreateKey() async {
    String? key = await _storage.read(key: _keyAlias);
    if (key == null) {
      final newKey = encrypt.Key.fromSecureRandom(32).base64;
      await _storage.write(key: _keyAlias, value: newKey);
      key = newKey;
    }
    return key;
  }

  Future<String> encryptData(String plainText) async {
    final keyBase64 = await _getOrCreateKey();
    final key = encrypt.Key.fromBase64(keyBase64);
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // Combine IV and CipherText for storage
    return '${iv.base64}:${encrypted.base64}';
  }

  Future<String> decryptData(String combined) async {
    final parts = combined.split(':');
    if (parts.length != 2) throw Exception('Invalid encrypted format');

    final iv = encrypt.IV.fromBase64(parts[0]);
    final cipherText = parts[1];

    final keyBase64 = await _getOrCreateKey();
    final key = encrypt.Key.fromBase64(keyBase64);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

    return encrypter.decrypt64(cipherText, iv: iv);
  }
}
