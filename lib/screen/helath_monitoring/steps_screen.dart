import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../constants/common_text.dart';

class Step_Count extends StatefulWidget {
  const Step_Count({Key? key}) : super(key: key);

  @override
  State<Step_Count> createState() => _Step_CountState();
}

class _Step_CountState extends State<Step_Count> {
  final _km = GlobalKey<FormState>();
  final _goalkm = GlobalKey<FormState>();
  TextEditingController km1 = TextEditingController();
  TextEditingController goalkm = TextEditingController();
  late double con1 = 0, con2 = 0;
  double sum = 0.0;
  double kcal = 0.0;
  double golrsul = 0.0;
  double time = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Step Count"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.05),
            child: Column(
              children: [
                CircularStepProgressIndicator(
                  totalSteps: 100,
                  currentStep: golrsul.round(),
                  stepSize: 10,
                  selectedColor: Colors.teal,
                  unselectedColor: Colors.white,
                  padding: 0,
                  width: Get.width * 0.8,
                  height: Get.height * 0.37,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        "Today's Step ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      con1 == 0
                          ? Image.asset(
                              "images/step_counter.png",
                              height: Get.height * 0.14,
                              color: Colors.teal,
                            )
                          : Center(
                              child: Text(
                                "${sum.toInt()}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Get.width * 0.05),
                              ),
                            ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        con2 != 0 ? "Goal :- ${goalkm.text}" : "Goal :- ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        golrsul <= 100
                            ? "Completed :- ${golrsul.toStringAsFixed(2)}%"
                            : "Completed :- Good",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.width * 0.045,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                  selectedStepSize: 15,
                  roundedCap: (_, __) => true,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: Colors.teal,
                            size: Get.height * 0.03,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            "${kcal.toStringAsFixed(2)} kcal",
                            style: TextStyle(
                                fontSize: Get.width * 0.04,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.teal,
                            size: Get.height * 0.03,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            "${km1.text} km",
                            style: TextStyle(
                                fontSize: Get.width * 0.04,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            size: Get.height * 0.03,
                            color: Colors.teal,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            "${time.toInt()} min",
                            style: TextStyle(
                                fontSize: Get.width * 0.04,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _km,
                          child: Comman_tax(
                            onchage: (value) {
                              setState(() {
                                con1 = double.parse(value);
                                _km.currentState!.validate();
                              });
                            },
                            contro: km1,
                            formate: [LengthLimitingTextInputFormatter(3)],
                            hint: "Km",
                            keybor: TextInputType.number,
                            obscur: false,
                            ontap: () {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter km";
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      Expanded(
                        child: Form(
                          key: _goalkm,
                          child: Comman_tax(
                            onchage: (value) {
                              setState(() {
                                con2 = double.parse(value);
                                _km.currentState!.validate();
                              });
                            },
                            ontap: () {},
                            contro: goalkm,
                            formate: [LengthLimitingTextInputFormatter(3)],
                            hint: "Goal Km",
                            keybor: TextInputType.number,
                            obscur: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter goalkm";
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_km.currentState!.validate()&& _goalkm.currentState!.validate()) {
                      setState(() {
                        sum = con1 * 1313;
                        kcal = sum * 0.04;
                        golrsul = con1 / con2 * 100;
                        time = sum * 0.009;
                      });
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('step')
                          .add({
                        'km': "${km1.text}",
                        'goalkm': "${goalkm.text}",
                        'kcal': "${kcal}",
                        'time': "${time}",
                        'score': "${golrsul.toStringAsFixed(2)}",
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.grey.shade900,
                          content: Text(
                            "Please enter km",
                            style: TextStyle(color: Colors.white),
                          )));
                    }
                  },
                  color: Colors.teal,
                  height: Get.height * 0.06,
                  minWidth: Get.width * 0.9,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white, fontSize: Get.width * 0.05),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
