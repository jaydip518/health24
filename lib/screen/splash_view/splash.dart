import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Informaction extends StatelessWidget {
  const Informaction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Health",
                  style: TextStyle(
                      color: Colors.teal.shade400,
                      fontStyle: FontStyle.italic,
                      fontSize: Get.width*0.09,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "24",
                  style: TextStyle(
                      color: Colors.orange.shade600,
                      fontStyle: FontStyle.italic,
                      fontSize: Get.width*0.09,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}