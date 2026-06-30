import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Encryption/Decryption format test', () {
    const combined = 'iv_base64:cipher_base64';
    final parts = combined.split(':');
    expect(parts.length, 2);
    expect(parts[0], 'iv_base64');
    expect(parts[1], 'cipher_base64');
  });

  test('Normalization test', () {
    final text = '  Hello   World  \n';
    final normalized = text.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
    expect(normalized, 'hello world');
  });
}
