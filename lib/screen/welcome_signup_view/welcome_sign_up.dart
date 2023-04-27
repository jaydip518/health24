import 'package:flutter/material.dart';
import 'package:medicine_reminder/screen/welcome_signup_view/welcome_sign_sign.dart';

class WELCOME_SIGNUP extends StatefulWidget {
  const WELCOME_SIGNUP({Key? key}) : super(key: key);

  @override
  State<WELCOME_SIGNUP> createState() => _WELCOME_SIGNUPState();
}

class _WELCOME_SIGNUPState extends State<WELCOME_SIGNUP> {
  @override
  Widget build(BuildContext context) {
    return Welcome_sign_siup();
  }
}
