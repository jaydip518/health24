import 'package:flutter/material.dart';
import 'package:medicine_reminder/screen/profile_view/reprot_bug.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'account_settings.dart';
import 'feeb_back.dart';

class SETTINGS extends StatefulWidget {
  const SETTINGS({Key? key}) : super(key: key);

  @override
  State<SETTINGS> createState() => _SETTINGSState();
}
class _SETTINGSState extends State<SETTINGS> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Settings"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
        leading: InkWell(onTap: () {
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.05),
              child: Column(
                children: [
                  ProfileMenu(
                    icon: Icons.report,
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => REPORT_BUG(),
                          ));
                    },
                    text: "Report Bug",
                  ),
                  SizedBox(
                    height: Get.height*0.02,
                  ),
                  ProfileMenu(
                    icon: Icons.policy,
                    press: () {
                      launchUrl(
                        Uri.parse(
                            'https://docs.google.com/document/d/1IrDHNSjmPOD63Vk-CfmpBZdi8pa0Y-ZVzgyIdb3a2VY/edit'),);
                    },
                    text: "Privacy policy",
                  ),
                  SizedBox(
                    height: Get.height*0.02,
                  ),
                  ProfileMenu(
                    icon: Icons.feedback,
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FEED_BACK(),
                          ));
                    },
                    text: "FeedBack",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ProfileMenu extends StatelessWidget {
  final icon,text;
  final VoidCallback press;
  const ProfileMenu({Key? key, this.icon, this.text, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: press,
      child: Container(
        height: Get.height*0.07,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(13)),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05),
          child: Row(
            children: [
              Icon(icon,color: Colors.white,),
              SizedBox(width: Get.width*0.06),
              Text(text,style: TextStyle(color: Colors.white,fontSize: Get.width*0.045),),
              Spacer(),
            //  Icon(Icons.arrow_forward_ios_rounded, color: Colors.teal.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
