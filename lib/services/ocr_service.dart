import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:io';

part 'ocr_service.g.dart';

@riverpod
class OcrService extends _$OcrService {
  late final TextRecognizer _textRecognizer;

  @override
  void build() {
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    ref.onDispose(() => _textRecognizer.close());
  }

  Future<String?> recognizeText(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    try {
      final recognizedText = await _textRecognizer.processImage(inputImage);
      return recognizedText.text;
    } catch (e) {
      print("OCR Error: $e");
      return null;
    }
  }
}
