import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  static final FlutterLocalNotificationsPlugin
      notifications =
      FlutterLocalNotificationsPlugin();

  static Future init() async {

    const android =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings =
        InitializationSettings(
      android: android,
    );

    await notifications.initialize(
      settings,
    );
  }

  static Future showAlertNotification(
  String title,
  String body,
) async {

  const androidDetails =
      AndroidNotificationDetails(
    'smartnav_alert',
    'SmartNav Alert',

    importance: Importance.max,
    priority: Priority.high,
  );

  const details =
      NotificationDetails(
    android: androidDetails,
  );

  await notifications.show(

    DateTime.now()
            .millisecondsSinceEpoch ~/
        1000,

    title,

    body,

    details,
  );
}
}