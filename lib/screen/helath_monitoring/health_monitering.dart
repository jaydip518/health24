import 'package:flutter/material.dart';
import 'helath.dart';

class Health_monitoring extends StatefulWidget {
  const Health_monitoring({Key? key}) : super(key: key);

  @override
  State<Health_monitoring> createState() => _Health_monitoringState();
}

class _Health_monitoringState extends State<Health_monitoring> {


  @override
  Widget build(BuildContext context) {
    return Helath();
  }
}
