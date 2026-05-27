import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  static final FlutterLocalNotificationsPlugin
      notifications =
      FlutterLocalNotificationsPlugin();

  /// INITIALIZE
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

  /// TEST NOTIFICATION
  static Future showTestNotification() async {

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
      0,
      'Tenkasi SmartNav',
      '10 minutes away from your stop',
      details,
    );
  }
}