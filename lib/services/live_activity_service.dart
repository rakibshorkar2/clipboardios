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
      await _liveActivities.createActivity({
        'content': content.length > 30 ? '${content.substring(0, 30)}...' : content,
        'status': 'Last clip saved',
      });
    } catch (e) {
      print("Live Activity error: $e");
    }
  }

  Future<void> endAllActivities() async {
    await _liveActivities.endAllActivities();
  }
}
