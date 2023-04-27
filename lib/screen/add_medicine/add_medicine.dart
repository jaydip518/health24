import 'dart:core' as mm;
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/screen/home_view/homeview.dart';
import '../../constants/common_button.dart';
import '../../constants/common_text.dart';
import 'package:timezone/timezone.dart' as tzz;
import 'package:timezone/data/latest.dart' as tz;
import '../navbar_view/navbar.dart';

 TextEditingController _addname = TextEditingController();
 TextEditingController _adddesc = TextEditingController();

  var addname;
  var adddesc;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class AddMedicins extends StatefulWidget {
  const AddMedicins({Key? key}) : super(key: key);

  @override
  State<AddMedicins> createState() => _AddMedicinsState();
}

class _AddMedicinsState extends State<AddMedicins> {


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
    if (_addname.text.isEmpty || _adddesc.text.isEmpty) return;

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high channel', 'show notification',
        description: "This is most improtant channel",
        importance: Importance.max,
        playSound: true);

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
        _addname.text,
        _adddesc.text,
        schedulAt,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                playSound: true,
                priority: Priority.max)),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
  }

  int selectMedicin = 0;

  DateTime dateTime = DateTime.now();

  List Map = [
    {
      "image": "https://cdn-icons-png.flaticon.com/128/807/807165.png",
      "medi": "Tablets",
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/128/822/822092.png",
      "medi": "Capsule",
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/128/4148/4148500.png",
      "medi": "Injection",
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/128/9408/9408727.png",
      "medi": "Bottle",
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/128/673/673561.png",
      "medi": "Home Made",
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/128/2447/2447774.png",
      "medi": "Water",
    },
  ];

  TextEditingController _editingController = TextEditingController();

  final name = GlobalKey<FormState>();
  final desc = GlobalKey<FormState>();
  int validator = 0;
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width*0.04, vertical: Get.height*0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Plan",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width*0.07,
                      fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectMedicin != _editingController;
                      });
                    },
                    child: Row(
                        children: List.generate(
                            6,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          selectMedicin = index;
                                        },
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(height: Get.height*0.04),
                                        Container(
                                          height: Get.height*0.08,
                                          width: Get.width*0.2,
                                          child: Center(
                                              child: Image.network(
                                            Map[index]["image"],
                                            width: Get.width*0.09,
                                          )),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: selectMedicin == index
                                                      ? Colors.teal.shade400
                                                      : Colors.transparent,
                                                  width: 3.5),
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        ),
                                        SizedBox(height: Get.width*0.03),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectMedicin = index;
                                            });
                                          },
                                          child: Text(
                                            Map[index]["medi"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: selectMedicin == index
                                                    ? Colors.teal.shade400
                                                    : Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
                  ),
                ),
                SizedBox(height: Get.height*0.04),
                Row(
                  children: [
                    Text(
                      "Medication",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: Get.height*0.01),
                Form(
                  key: name,
                  child: Comman_tax(
                    ontap: () {
                      setState(() {
                        addname=_adddesc;
                      });
                    },
                    onchage: (value) {
                      name.currentState!.validate();
                    },
                    hint: " Medicine Name",
                    obscur: false,
                    key: name,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "enter the value";
                      }
                    },
                    contro: _addname,
                  ),
                ),
                SizedBox(height: Get.height*0.02),
                Form(
                  key: desc,
                  child: Comman_tax(
                    ontap: () {
                      setState(() {
                        adddesc=_adddesc;
                      });
                    },
                    key: desc,
                    onchage: (value) {
                      desc.currentState!.validate();
                    },
                    hint: " Description",
                    obscur: false,
                    contro: _adddesc,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "enter the value";
                      }
                    },
                  ),
                ),
                SizedBox(height: Get.height*0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Set Reminder",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height*0.02,
                        ),
                        Row(
                          children: [
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
                                width: Get.width*0.4,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.grey.shade400)),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {},
                                        icon: Icon(
                                          Icons.alarm,
                                          color: Color(0xff555555),
                                        )),
                                    Text("Time  ${hours}:${minute}",
                                        style:
                                            TextStyle(color: Color(0xff555555))),
                                    SizedBox(
                                      width: Get.width*0.02,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Select Date",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height*0.02,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                final date = await pickDate();
                                if (date == null) {
                                  return;
                                }
                                final newDateTime = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  dateTime.hour,
                                  dateTime.minute,
                                );
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              },
                              child: Container(
                                height: Get.height*0.055,
                                width: Get.width*0.4,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width*0.04,
                                    ),
                                    Icon(
                                      Icons.date_range,
                                      color: Color(0xff555555),
                                    ),
                                    Text(
                                      "${dateTime.year}/${dateTime.month}/${dateTime.day}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.grey.shade400)),
                              ),
                            ),
                          ],
                        )
                      ],
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
                        .collection('medecine')
                        .add({
                      'chooseMedecine': "${selectMedicin}",
                      'medicineName': _addname.text,
                      'desc': _adddesc.text,
                      'Reminder': "${hours}:${minute}",
                      'Time': "${dateTime}",
                    });
                    _addname.clear();
                    _adddesc.clear();
                    Get.to(Navbar());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
