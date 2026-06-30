import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:googleapis/drive/v3.dart' as drive;

part 'auth_service.g.dart';

@riverpod
class AuthService extends _$AuthService {
  late final GoogleSignIn _googleSignIn;

  @override
  FutureOr<GoogleSignInAccount?> build() async {
    _googleSignIn = GoogleSignIn.standard(
      scopes: [
        drive.DriveApi.driveAppdataScope,
      ],
    );
    return _googleSignIn.signInSilently();
  }

  Future<GoogleSignInAccount?> signIn() async {
    state = const AsyncValue.loading();
    try {
      final user = await _googleSignIn.signIn();
      state = AsyncValue.data(user);
      return user;
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
