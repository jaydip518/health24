import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constants/common_button.dart';
import '../signin_view/sign_in_screen.dart';
import '../signup_view/sign_up_screen.dart';

class Welcome_sign_siup extends StatefulWidget {
  const Welcome_sign_siup({Key? key}) : super(key: key);

  @override
  State<Welcome_sign_siup> createState() => _Welcome_sign_siupState();
}

class _Welcome_sign_siupState extends State<Welcome_sign_siup> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: Get.height*0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal.shade400,
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(65)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: Get.height*0.02, horizontal: Get.width*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.off(LOGIN_SCREEN());
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: Get.width*0.06),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Lottie.asset("images/94903-health.json"),
                ],
              ),
            ),
            SizedBox(
              height: Get.height*0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.height*0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Welcome to your\npill reminder!",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width*0.075),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height*0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        "We will remind you to take your meds,\nand,if necessary,contact your doctor",
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: Get.width*0.045),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.width*0.1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
              child: material().button(
                text: 'Signup',
                ontap: () {
                  Get.off(SIGNUP_SCREEN());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
