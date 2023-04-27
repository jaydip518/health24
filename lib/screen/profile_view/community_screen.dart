import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class COMUNITY_SCREEN extends StatefulWidget {
  const COMUNITY_SCREEN({Key? key}) : super(key: key);

  @override
  State<COMUNITY_SCREEN> createState() => _COMUNITY_SCREENState();
}

class _COMUNITY_SCREENState extends State<COMUNITY_SCREEN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
        leading: InkWell(onTap: () {
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.04),
            child: Container(
              width: double.infinity,
              height: Get.height*0.22,
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, top: 30, right: 10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              maxRadius: Get.width*0.07,
                              backgroundImage: NetworkImage(
                                  "https://www.shutterstock.com/image-vector/letter-h-logo-icon-design-260nw-257898641.jpg"),
                            ),
                            SizedBox(
                              height: Get.height*0.02,
                            ),
                            Text(
                              "Helth24",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width*0.05),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Share.share('Community');
                              },
                              child: Container(
                                height: Get.height*0.06,
                                width: Get.width*0.4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Share",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Get.width*0.045,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.teal.shade400,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                            SizedBox(
                              height: Get.height*0.03,
                            ),
                            Text("Joins Together",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.width*0.055)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
