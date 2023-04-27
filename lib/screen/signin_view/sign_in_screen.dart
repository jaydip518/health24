import 'package:flutter/material.dart';
import 'package:medicine_reminder/screen/signin_view/signin.dart';

class LOGIN_SCREEN extends StatefulWidget {
  const LOGIN_SCREEN({Key? key}) : super(key: key);

  @override
  State<LOGIN_SCREEN> createState() => _LOGIN_SCREENState();
}

class _LOGIN_SCREENState extends State<LOGIN_SCREEN> {


  @override
  Widget build(BuildContext context) {
    return Signin();
  }
}
