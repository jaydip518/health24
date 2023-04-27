import 'dart:async';
import 'package:get/get.dart';
import 'package:medicine_reminder/screen/splash_view/splash.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/screen/welcome_view/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/getx_controllers.dart';
import '../navbar_view/bottom_navigation_bar.dart';

class SPLASH_SCREEN extends StatefulWidget {
  const SPLASH_SCREEN({Key? key}) : super(key: key);

  @override
  State<SPLASH_SCREEN> createState() => _SPLASH_SCREENState();
}

class _SPLASH_SCREENState extends State<SPLASH_SCREEN> {
  helathController helathcontroller=Get.put(helathController());
  String? username;

  Future getusername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final name = preferences.getString('email');
    setState(() {
      username = name;
    });
  }

  @override
  void initState() {
    getusername().whenComplete(
      () => Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                username == null ? WELCOME_SCREEN() : Navigator_bar(),
          ),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Informaction();
  }
}
