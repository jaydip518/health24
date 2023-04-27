import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class noti{
  void sendNotification({String? title,String? body}) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
    );

    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(defaultActionName: 'Open notification');


    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high channel', 'show notification',
        description: "This is most improtant channel",
        importance: Importance.max,playSound: true);

    flutterLocalNotificationsPlugin.show(0, title, body, NotificationDetails(
        android:AndroidNotificationDetails(channel.id,channel.name,channelDescription: channel.description)
    ));
  }
}