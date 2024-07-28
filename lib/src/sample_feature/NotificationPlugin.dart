import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones(); // <---- Make this change.
    tz.setLocalLocation(tz.getLocation("America/Denver"));
  }
  void showNotificationAndroid(String title, String value) async {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('channel_id', 'Channel Name',
              channelDescription: 'Channel Description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker');

      int notification_id = 1;
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin
          .show(notification_id, title, value, notificationDetails, payload: 'Not present');
  }
  Future<void> showTimedNotification() async{
    int notification_id = 2;
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Time To Do Your CheckIn!!! :)',
        'It Will Help Your Brain ;)',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        const NotificationDetails(
           android: AndroidNotificationDetails('channel_id', 'Channel Name',
              channelDescription: 'Channel Description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    print("await finished");
  }
  Future<void> scheduleNotification() async {
    var scheduleNotificationDateTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 20));
    var androidChannelSpecifics = const AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      enableLights: true,
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
  
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Time To Do Your CheckIn!!! :)',
      'It Will Help Your Brain ;)',
      scheduleNotificationDateTime,
      NotificationDetails(android: androidChannelSpecifics),
      payload: 'Test Payload',
      uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
  Future<void> scheduleNotificationDaily() async {
    var scheduleNotificationDateTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
    var androidChannelSpecifics = const AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      enableLights: true,
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'Time To Do Your CheckIn!!! :)',
    'It Will Help Your Brain ;)', RepeatInterval.daily, NotificationDetails(android: androidChannelSpecifics),
    androidAllowWhileIdle: true);
  }
}

