import 'package:flutter/material.dart';
import 'package:medicine_reminder/screen/navbar_view/navbar.dart';

class Navigator_bar extends StatefulWidget {
  const Navigator_bar({Key? key}) : super(key: key);

  @override
  State<Navigator_bar> createState() => _Navigator_barState();
}

class _Navigator_barState extends State<Navigator_bar> {


  @override
  Widget build(BuildContext context) {
    return Navbar();
  }
}
