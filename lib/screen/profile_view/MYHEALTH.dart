import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/screen/profile_view/show_bmi.dart';
import 'package:medicine_reminder/screen/profile_view/show_step.dart';
import 'package:medicine_reminder/screen/profile_view/show_water.dart';
import 'show_heartrate.dart';


class MYHEALTH extends StatefulWidget {
  const MYHEALTH({Key? key}) : super(key: key);

  @override
  State<MYHEALTH> createState() => _MYHEALTHState();
}

class _MYHEALTHState extends State<MYHEALTH> {
  List screen=[
    SHOW_HEARTRATE(),
    SHOW_WATER(),
    SHOW_BMI(),
    SHOW_STEP(),
  ];
  List name=["Heart rate","Water","Bmi","Step"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My helath"),
        centerTitle: true,
        leading: InkWell(onTap: () {
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.teal.shade400,
      ),
      body:  SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: Get.height*0.03,horizontal: Get.width*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        height: Get.height*0.1,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: Get.height*0.02),
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              name[index],
                              style: TextStyle(
                                fontSize: Get.width*0.05,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
