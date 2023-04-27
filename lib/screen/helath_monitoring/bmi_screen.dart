import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/screen/helath_monitoring/score_screen.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'age_calculet.dart';
import 'package:page_transition/page_transition.dart';

class BMI_SCREEN extends StatefulWidget {
  const BMI_SCREEN({Key? key}) : super(key: key);

  @override
  State<BMI_SCREEN> createState() => _BMI_SCREENState();
}

class _BMI_SCREENState extends State<BMI_SCREEN> {
  int height = 150;
  int counter = 0;
  int age = 30;
  int weight = 50;
  bool finish = false;
  double bmiScroe = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height*0.04,),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Card(
              color: Colors.white,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height*0.04,),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ChoiceChip3D(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              style: ChoiceChip3DStyle(
                                  topColor: Colors.white,
                                  backColor: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                              onSelected: () {
                                setState(() {
                                  counter = 1;
                                });
                              },
                              onUnSelected: () {},
                              selected: counter == 1,
                              child: Padding(
                                padding:
                                     EdgeInsets.symmetric(vertical: Get.height*0.01,),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "images/man.png",
                                      width: Get.width*0.09,
                                    ),
                                    SizedBox(
                                      height: Get.height*0.015,
                                    ),
                                    Text(
                                      "Male",
                                      style: TextStyle(
                                          fontSize: Get.width*0.04,
                                          color: Color(0xff555555)),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          width: Get.width*0.06,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ChoiceChip3D(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              style: ChoiceChip3DStyle(
                                  topColor: Colors.white,
                                  backColor: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                              onSelected: () {
                                setState(() {
                                  counter = 2;
                                });
                              },
                              onUnSelected: () {},
                              selected: counter == 2,
                              child: Padding(
                                padding:
                                     EdgeInsets.symmetric(vertical: Get.height*0.01,),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "images/woman.png",
                                      width: Get.width*0.09,
                                    ),
                                    SizedBox(
                                      height: Get.height*0.015,
                                    ),
                                    Text("Female",
                                        style: TextStyle(
                                            fontSize: Get.width*0.04,
                                            color: Color(0xff555555))),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:Get.height*0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                      child: Card(
                        color: Colors.white,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height*0.01,
                            ),
                            Text(
                              "Height",
                              style: TextStyle(
                                  fontSize: Get.width*0.055, color:Color(0xff555555)),
                            ),
                            SizedBox(
                              height: Get.height*0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  height.toString(),
                                  style: TextStyle(
                                      fontSize: Get.width*0.06, color: Color(0xff555555)),
                                ),
                                Text(" cm",
                                    style: TextStyle(
                                        fontSize: Get.width*0.06, color: Color(0xff555555))),
                              ],
                            ),
                            SizedBox(
                              height: Get.height*0.01,
                            ),
                            Slider(
                              inactiveColor: Colors.grey,
                              activeColor: Colors.teal.shade400,
                              value: height.toDouble(),
                              onChanged: (value) {
                                setState(() {
                                  height = value.toInt();
                                });
                              },
                              min: 0,
                              max: 240,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height*0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AGE_CALCULATE(
                          onchange: (ageval) {
                            age = ageval;
                          },
                          title: 'Age',
                          invalue: 30,
                          min: 0,
                          max: 100,
                        ),
                        SizedBox(
                          width: Get.width*0.02,
                        ),
                        AGE_CALCULATE(
                          onchange: (ageval) {
                            weight = ageval;
                          },
                          title: 'Weight(Kg)',
                          invalue: 50,
                          min: 0,
                          max: 200,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height*0.07,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                      child: SwipeableButtonView(
                          onFinish: () async {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid).collection('bmi').add({
                              'gender':"${counter}",
                              'height':"${height}",
                              'age':"${age}",
                              'weight':"${weight}",
                              'bmi':"${bmiScroe.toStringAsFixed(2)}",
                            });
                            await Navigator.push(
                                context,
                                PageTransition(
                                    child: SCORE_SCREEN(
                                        bmiscore: bmiScroe, age: age),
                                    type: PageTransitionType.fade));
                            setState(() {
                              finish = false;
                            });
                          },
                          isFinished: finish,
                          onWaitingProcess: () {
                            calculateBmi();
                            Future.delayed(
                              Duration(seconds: 1),
                              () {
                                setState(() {
                                  finish = true;
                                });
                              },
                            );
                          },
                          activeColor: Colors.teal,
                          buttonWidget: Icon(Icons.arrow_forward_ios),
                          buttonText: "CALCULATE",
                      ),
                    ),
                    SizedBox(
                      height: Get.height*0.01,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void calculateBmi() {
    bmiScroe = weight / pow(height / 100, 2);
  }
}
