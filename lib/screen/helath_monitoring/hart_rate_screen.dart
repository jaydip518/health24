import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_reminder/constants/getx_controllers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HEART_RATE_SCREEN extends StatefulWidget {
  @override
  _HEART_RATE_SCREENState createState() => _HEART_RATE_SCREENState();
}

String Age = "Age 1 to 20";
String Height = "4";

helathController helathcontroller=Get.put(helathController());

class _HEART_RATE_SCREENState extends State<HEART_RATE_SCREEN> {
  int stor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart BPM Demo'),
        backgroundColor: Colors.teal.shade400,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal:  Get.width*0.04,vertical:  Get.height*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Select Age",
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height:  Get.height*0.03,
                      ),
                      DropdownButton<String>(
                          onChanged: (value) {
                            setState(() {
                              Age=value!;
                            });
                          },
                          underline: SizedBox(),
                          value: Age,
                          //dropdownColor: Colors.teal,
                          items: [
                            DropdownMenuItem(
                                child: Text("Age 1 to 20"), value: "Age 1 to 20"),
                            DropdownMenuItem(
                              child: Text("Age 20 to 30"),
                              value: "Age 20 to 30",
                            ),
                            DropdownMenuItem(
                              child: Text("Age 30 to 40"),
                              value: "Age 30 to 40",
                            ),
                            DropdownMenuItem(
                              child: Text("Age 40 to 50"),
                              value: "Age 40 to 50",
                            ),
                            DropdownMenuItem(
                              child: Text("Age 50 to 60"),
                              value: "Age 50 to 60",
                            ),
                            DropdownMenuItem(
                              child: Text("Age 60 to 70"),
                              value: "Age 60 to 70",
                            ),
                            DropdownMenuItem(
                              child: Text("Age 70 to 80"),
                              value: "Age 70 to 80",
                            ),
                            DropdownMenuItem(
                              child: Text("Age 80 to 90"),
                              value: "Age 80 to 90",
                            ),
                            DropdownMenuItem(
                              child: Text("Age 90 to 100"),
                              value: "Age 90 to 100",
                            ),
                          ]),
                    ],
                  ),
                  SizedBox(
                    width:  Get.width*0.04,
                  ),
                  Column(
                    children: [
                      Text("Select Height"),
                      SizedBox(
                        height:  Get.height*0.03,
                      ),
                      DropdownButton<String>(
                          onChanged: (value) {
                            setState(() {
                              Height = value!;
                            });
                          },
                          value: Height,
                          underline: SizedBox(),
                          //dropdownColor: Colors.teal,
                          items: [
                            DropdownMenuItem(
                              child: Text("4"),
                              value: "4",
                            ),
                            DropdownMenuItem(
                              child: Text("4.5"),
                              value: "4.5",
                            ),
                            DropdownMenuItem(
                              child: Text("5"),
                              value: "5",
                            ),
                            DropdownMenuItem(
                              child: Text("5.5"),
                              value: "5.5",
                            ),
                            DropdownMenuItem(
                              child: Text("6"),
                              value: "6",
                            ),
                            DropdownMenuItem(
                              child: Text("6.5"),
                              value: "6.5",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "7",
                              ),
                              value: "7",
                            ),
                            DropdownMenuItem(
                              child: Text("7.5"),
                              value: "7.5",
                            ),
                            DropdownMenuItem(
                              child: Text("8"),
                              value: "8",
                            ),
                          ]),
                    ],
                  ),
                ],
              ),
            ),
            Lottie.asset("images/129223-heart-rate.json",
                width: double.infinity, height:  Get.height*0.4),
            SizedBox(
              height:  Get.height*0.03,
            ),
            Text(
              "${stor} BPM",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:  Get.width*0.06),
            ),
            SizedBox(
              height:  Get.height*0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:  Get.width*0.05),
              child: MaterialButton(
                onPressed: () {
                  if (Age == "Age 1 to 20") {
                    setState(() {
                      stor = 90;
                    });
                  } else if (Age == "Age 20 to 30") {
                    setState(() {
                      stor = 65;
                    });
                  } else if (Age == "Age 30 to 40") {
                    setState(() {
                      stor = 70;
                    });

                  } else if (Age == "Age 40 to 50") {
                    setState(() {
                      stor = 60;
                    });
                  } else if (Age == "Age 50 to 60") {
                    setState(() {
                      stor = 55;
                    });
                  } else if (Age == "Age 60 to 70") {
                    setState(() {
                      stor = 52;
                    });
                  } else if (Age == "Age 70 to 80") {
                    setState(() {
                      stor = 50;
                    });
                  } else if (Age == "Age 80 to 90") {
                    setState(() {
                      stor = 50;
                    });
                  } else if (Age == "Age 90 to 100") {
                    setState(() {
                      stor = 45;
                    });
                  }
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid).
                      collection('hartrate').add({
                    'Age':"${Age}",
                    'height':"${Height}",
                    'heartrate':"${stor}"
                  });
                },
                minWidth: double.infinity,
                height:  Get.height*0.06,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.teal.shade400,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
