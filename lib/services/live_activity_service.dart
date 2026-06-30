import 'dart:convert';
import 'package:live_activities/live_activities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_activity_service.g.dart';

@riverpod
class LiveActivityService extends _$LiveActivityService {
  final LiveActivities _liveActivities = LiveActivities();

  @override
  void build() {}

  Future<void> startActivity(String content) async {
    try {
      final data = {
        'content': content.length > 30 ? '${content.substring(0, 30)}...' : content,
        'status': 'Last clip saved',
      };
      // Passing content string and data map as expected by live_activities plugin
      await _liveActivities.createActivity(content, data);
    } catch (e) {
      print("Live Activity error: $e");
    }
  }

  Future<void> endAllActivities() async {
    await _liveActivities.endAllActivities();
  }
}
