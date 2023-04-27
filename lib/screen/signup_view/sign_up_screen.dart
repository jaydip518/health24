import 'package:flutter/material.dart';
import 'package:medicine_reminder/screen/signup_view/signup.dart';

class SIGNUP_SCREEN extends StatefulWidget {
  const SIGNUP_SCREEN({Key? key}) : super(key: key);

  @override
  State<SIGNUP_SCREEN> createState() => _SIGNUP_SCREENState();
}

class _SIGNUP_SCREENState extends State<SIGNUP_SCREEN> {
  

  @override
  Widget build(BuildContext context) {
    return Signup();
  }
}
