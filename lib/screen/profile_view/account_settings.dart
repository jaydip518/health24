import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../add_medicine/add_medicine.dart';

class ACCOUNT_SEETINGS extends StatefulWidget {
  const ACCOUNT_SEETINGS({Key? key}) : super(key: key);

  @override
  State<ACCOUNT_SEETINGS> createState() => _ACCOUNT_SEETINGSState();
}

class _ACCOUNT_SEETINGSState extends State<ACCOUNT_SEETINGS> {
  bool items=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account Settings"),centerTitle: true,backgroundColor: Colors.teal.shade400,),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.04),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Notification",style: TextStyle(fontSize: Get.width*0.045),),
                  Switch(value: items, onChanged: (value) {
                    setState(() {
                      items=value;
                      if(items==true){
                        flutterLocalNotificationsPlugin.cancelAll();
                      }
                    });
                  },)
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
