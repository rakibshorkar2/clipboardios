import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metadata_service.g.dart';

@riverpod
class MetadataService extends _$MetadataService {
  @override
  void build() {}

  Future<Map<String, String>> fetchMetadata(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) return {};

      final document = parser.parse(response.body);
      final metadata = <String, String>{};

      // Title
      metadata['title'] = document.querySelector('title')?.text ?? '';
      
      // Open Graph
      final metaTags = document.getElementsByTagName('meta');
      for (var tag in metaTags) {
        final property = tag.attributes['property'] ?? tag.attributes['name'];
        final content = tag.attributes['content'];
        
        if (content != null) {
          if (property == 'og:title') metadata['title'] = content;
          if (property == 'og:description' || property == 'description') metadata['description'] = content;
          if (property == 'og:image') metadata['image'] = content;
          if (property == 'og:site_name') metadata['siteName'] = content;
        }
      }

      // Favicon
      final iconTag = document.querySelector('link[rel*="icon"]');
      if (iconTag != null) {
        var iconUrl = iconTag.attributes['href'] ?? '';
        if (iconUrl.startsWith('/')) {
          final uri = Uri.parse(url);
          iconUrl = '${uri.scheme}://${uri.host}$iconUrl';
        }
        metadata['icon'] = iconUrl;
      }

      return metadata;
    } catch (e) {
      print("Metadata Error: $e");
      return {};
    }
  }
}
