import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bmi_screen.dart';
import 'hart_rate_screen.dart';
import 'steps_screen.dart';
import 'water.dart';

class Helath extends StatefulWidget {
  const Helath({Key? key}) : super(key: key);

  @override
  State<Helath> createState() => _HelathState();
}

class _HelathState extends State<Helath> {
  List tax = [
    {
      "tax": "Heart rate",
      "Image": "images/pulse.png",
    },
    {
      "tax": "Water",
      "Image": "images/water.png",
    },
    {
      "tax": "BMI",
      "Image": "images/body-mass-index.png",
    },
    {
      "tax": "Steps",
      "Image": "images/footprint.png",
    },
  ];
  List screen=[
    HEART_RATE_SCREEN(),
    WATER(),
    BMI_SCREEN(),
    Step_Count(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.045,vertical: Get.height*0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Health monitoring",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize:  Get.width*0.07,
                  ),
                ),
                SizedBox(
                  height: Get.height*0.04,
                ),
                Column(
                  children: List.generate(
                      4,
                          (index) => InkWell(
                        onTap: () {
                          setState(() {
                            screen==index;
                            Get.to(screen[index]);
                          });
                        },
                        child: Container(
                          height:  Get.height*0.1,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical:  Get.height*0.02),
                          decoration: BoxDecoration(
                              color: Colors.teal.shade400,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                tax[index]["tax"],
                                style: TextStyle(
                                  fontSize:  Get.width*0.05,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Image.asset(
                                tax[index]["Image"],
                                height:  Get.height*0.05,
                              ),
                            ],
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
