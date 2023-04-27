import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ABOUT_US_SCREEN extends StatefulWidget {
  const ABOUT_US_SCREEN({Key? key}) : super(key: key);

  @override
  State<ABOUT_US_SCREEN> createState() => _ABOUT_US_SCREENState();
}

class _ABOUT_US_SCREENState extends State<ABOUT_US_SCREEN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
        leading: InkWell(onTap: () {
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Medicine Reminder",
              style: TextStyle(fontSize: Get.width*0.06),
            ),
            SizedBox(
              height: Get.height*0.01,
            ),
            Text(
              "Version 1.1.0",
              style: TextStyle(color: Colors.grey, fontSize: Get.width*0.045),
            ),
            SizedBox(
              height: Get.height*0.04,
            ),
            Image.asset(
              "images/logo-removebg-preview.png",
              height: Get.height*0.1,
            ),
            SizedBox(
              height: Get.height*0.04,
            ),
            Text(
              "© 2023 Medicine Inc",
              style: TextStyle(color: Colors.grey, fontSize:Get.width*0.04),
            ),
            SizedBox(
              height: Get.width*0.04,
            ),
            // MaterialButton(
            //   onPressed: () {},
            //   height: 5.h,
            //   minWidth: 10.w,
            //   color: Colors.teal.shade300,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5)),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     child: Text(
            //       "Licenses",
            //       style: TextStyle(
            //           color: Colors.black, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
