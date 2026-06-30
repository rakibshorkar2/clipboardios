import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_service.g.dart';

@riverpod
class NotificationService extends _$NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  @override
  FutureOr<void> build() async {
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(iOS: initializationSettingsIOS);
    await _notifications.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    const notificationDetailsIOS = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(iOS: notificationDetailsIOS);
    await _notifications.show(0, title, body, notificationDetails);
  }
}
