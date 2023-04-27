import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/screen/welcome_view/welcome.dart';
import 'package:medicine_reminder/screen/signup_view/sign_up_screen.dart';
import 'package:medicine_reminder/screen/welcome_signup_view/welcome_sign_up.dart';

import '../navbar_view/bottom_navigation_bar.dart';

class WELCOME_SCREEN extends StatefulWidget {
  const WELCOME_SCREEN({Key? key}) : super(key: key);

  @override
  State<WELCOME_SCREEN> createState() => _WELCOME_SCREENState();
}

class _WELCOME_SCREENState extends State<WELCOME_SCREEN> {


  @override
  Widget build(BuildContext context) {
    return Welcome();
  }
}
