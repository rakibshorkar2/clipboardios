import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:googleapis/drive/v3.dart' as drive;

part 'auth_service.g.dart';

@riverpod
class AuthService extends _$AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  FutureOr<GoogleSignInAccount?> build() async {
    // Mandatory initialization for v7.2.0+
    await _googleSignIn.initialize();

    _googleSignIn.authenticationEvents.listen((event) {
      if (event is GoogleSignInAuthenticationEventSignIn) {
        state = AsyncValue.data(event.user);
      } else if (event is GoogleSignInAuthenticationEventSignOut) {
        state = const AsyncValue.data(null);
      }
    }, onError: (e, st) {
      state = AsyncValue.error(e, st);
    });

    try {
      return await _googleSignIn.attemptLightweightAuthentication();
    } catch (_) {
      return null;
    }
  }

  Future<GoogleSignInAccount?> signIn() async {
    state = const AsyncValue.loading();
    try {
      final result = await _googleSignIn.authenticate(
        scopeHint: [drive.DriveApi.driveAppdataScope],
      );
      
      // authenticate() returns the account directly in some cases or we get it via event
      // Based on docs, authenticate() returns the account if successful.
      state = AsyncValue.data(result);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    state = const AsyncValue.data(null);
  }
}
