import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:timezone/timezone.dart' as tzz;
import 'package:timezone/data/latest.dart' as tz;
import '../../constants/common_button.dart';
import '../../model/shar_pref.dart';

class WATER extends StatefulWidget {
  const WATER({Key? key}) : super(key: key);

  @override
  State<WATER> createState() => _WATERState();
}

class _WATERState extends State<WATER> {
  DateTime dateTime = DateTime.now();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
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
  }

  showNotification() {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high channel', 'show notification',
        description: "This is most improtant channel",
        importance: Importance.max,
        playSound: true,
    );

    // flutterLocalNotificationsPlugin.show(
    //   0,
    //   _name.text,
    //   _desc.text,
    //   NotificationDetails(
    //       android: AndroidNotificationDetails(channel.id, channel.name,
    //           channelDescription: channel.description,
    //           importance: Importance.high,
    //           color: Colors.white)),
    // );
    tz.initializeTimeZones();

    final tzz.TZDateTime schedulAt = tzz.TZDateTime.from(dateTime, tzz.local);

    print(dateTime);

    flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Water",
        "Please drink the water",
        schedulAt,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                playSound: true,
                priority: Priority.max,
            )),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
  }

  Duration duration = Duration(hours: 1, minutes: 23);
  bool items=false;

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
        appBar: AppBar(
          title: Text('Drinking water'),centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.teal.shade400,
        ),
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:  Get.height*0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal.shade400,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:  Get.height*0.05,),
              child: Column(
                children: [
                  Lottie.asset("images/15421-glass-of-water.json",
                      height: Get.height*0.15,),
                  SizedBox(
                    height: Get.height*0.05,
                  ),
                  Text(
                    "Notify you drink water on time",
                    style: TextStyle(color: Colors.white, fontSize: Get.width*0.05,),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: Get.height*0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Drinking water reminder",
                      style: TextStyle(fontSize: Get.width*0.05,color: Colors.orange,fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height*0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Time",
                      style: TextStyle(fontSize: Get.width*0.05,),
                    ),
                    InkWell(
                      onTap: () async {
                        final time = await pickTime();
                        if (time == null) {
                          return;
                        }
                        final newDateTime = DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                          time.hour,
                          time.minute,
                        );
                        setState(() {
                          dateTime = newDateTime;
                        });
                      },
                      child: Container(
                        height: Get.height*0.055,
                        width: Get.width*0.45,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width*0.03,
                            ),
                            IconButton(
                                onPressed: () async {},
                                icon: Icon(
                                  Icons.alarm,
                                  color: Color(0xff555555),
                                )),
                            Text("Time  ${hours}:${minute}",
                                style: TextStyle(color: Color(0xff555555))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height*0.06,
                ),
                material().button(
                  text: "Add Medicine",
                  ontap: () async {
                    showNotification();
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('water')
                        .add({
                      'Time': "${dateTime}",
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
