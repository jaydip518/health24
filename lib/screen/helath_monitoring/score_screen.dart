import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

class SCORE_SCREEN extends StatelessWidget {
  final double bmiscore;
  final int age;
  String? bmiStatus;
  String? bmiInterpretation;
  Color? bmiStatusColor;

  SCORE_SCREEN({Key? key, required this.bmiscore, required this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    setBmiIntepretation();
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculate BMI"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
      ),
      body: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Score"),
            PrettyGauge(
              gaugeSize: 300,
              maxValue: 40,
              minValue: 0,
              segments: [
                GaugeSegment('UnderWeight', 18.5, Colors.red),
                GaugeSegment('Normal', 6.4, Colors.green),
                GaugeSegment('OverWeight', 5, Colors.orange),
                GaugeSegment('Obese', 10.1, Colors.pink),
              ],
              valueWidget: Text(
                bmiscore.toStringAsFixed(1),
                style: TextStyle(fontSize: Get.width*0.06),
              ),
              currentValue: bmiscore.toDouble(),
            ),
            SizedBox(
              height: Get.height*0.07,
            ),
            Text(
              bmiStatus!,
              style: TextStyle(fontSize: Get.height*0.03, color: bmiStatusColor!),
            ),
            SizedBox(
              height: Get.height*0.04,
            ),
            Text(
              bmiInterpretation!,
              style: TextStyle(fontSize: Get.height*0.025),
            ),
            SizedBox(
              height: Get.height*0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    Share.share(
                        "Your BMI is ${bmiscore.toStringAsFixed(1)} at age $age");
                  },
                  child: Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.teal.shade400,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void setBmiIntepretation() {
    if (bmiscore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.pink;
    } else if (bmiscore >= 25) {
      bmiStatus = "OverWeight";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Colors.orange;
    } else if (bmiscore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy,You are fit";
      bmiStatusColor = Colors.green;
    } else if (bmiscore < 18.5) {
      bmiStatus = "UnderWeight";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Colors.red;
    }
  }
}
