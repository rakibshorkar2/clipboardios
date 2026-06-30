import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'biometric_service.g.dart';

@riverpod
class BiometricService extends _$BiometricService {
  final _auth = LocalAuthentication();
  static const _storage = FlutterSecureStorage();
  static const _lockKey = 'clipvault_biometric_lock';

  @override
  FutureOr<bool> build() async {
    final enabled = await _storage.read(key: _lockKey);
    return enabled == 'true';
  }

  Future<void> setEnabled(bool enabled) async {
    await _storage.write(key: _lockKey, value: enabled.toString());
    state = AsyncValue.data(enabled);
  }

  Future<bool> authenticate() async {
    final isEnabled = state.value ?? false;
    if (!isEnabled) return true;

    try {
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to unlock ClipVault',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print("Auth error: $e");
      return false;
    }
  }
}
