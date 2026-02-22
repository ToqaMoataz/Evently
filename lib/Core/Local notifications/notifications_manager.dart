import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import '../Models/event_model.dart';

class NotificationsManager {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    tz.initializeTimeZones();

    try {
      final String timeZoneName =
          (await FlutterTimezone.getLocalTimezone()).identifier;
      tz.setLocalLocation(tz.getLocation(timeZoneName));
      print("Timezone: $timeZoneName");
    } catch (e) {
      print("Timezone error: $e");
    }

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: _onTap,
    );

    if (Platform.isAndroid) {
      final androidPlugin = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      await androidPlugin?.requestNotificationsPermission();

      final canSchedule = await androidPlugin?.canScheduleExactNotifications();
      if (canSchedule == false) {
        await androidPlugin?.requestExactAlarmsPermission();
      }
    }
  }

  static void _onTap(NotificationResponse response) {

  }

  static NotificationDetails getNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'event_channel',
        'Event Notifications',
        channelDescription: 'Notifications for your events',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future<void> showNotification(EventModel event) async {
    await flutterLocalNotificationsPlugin.show(
      id: event.id.hashCode.abs(),
      title: event.title,
      body: event.description,
      payload: event.id,
      notificationDetails: getNotificationDetails(),
    );
  }

  static Future<void> scheduleNotification(EventModel event) async {
    try {
      var scheduledDate = tz.TZDateTime.from(event.dateTime, tz.local);

      if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
        scheduledDate = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id: event.id.hashCode.abs(),
        title: event.title,
        body: event.description,
        scheduledDate: scheduledDate,
        notificationDetails: getNotificationDetails(),
        payload: event.id,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
      print("Notification scheduled successfully for: $scheduledDate");
    } catch (e) {
      print("Notification scheduling failed: $e");
    }
  }


  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id: id);
  }

}
