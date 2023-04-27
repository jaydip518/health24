import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/constants/common_button.dart';
import 'package:medicine_reminder/firebase_servies/google_serviec.dart';
import 'package:medicine_reminder/screen/home_view/homeview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../welcome_signup_view/welcome_sign_up.dart';

class LOGOUT extends StatefulWidget {
  const LOGOUT({Key? key}) : super(key: key);

  @override
  State<LOGOUT> createState() => _LOGOUTState();
}

class _LOGOUTState extends State<LOGOUT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logout"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
        leading: InkWell(onTap: () {
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height*0.04,),
              material().button(text: "Sign out", ontap: () async{
                try {
                  setState(() {
                    storage.write('image', null);
                  });
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  await sharedPreferences.remove('name');
                  await sharedPreferences.remove('email');
                  await sharedPreferences.remove('imageUrl');
                  googleservice.googleSignOut().then(
                        (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WELCOME_SIGNUP(),
                      ),
                    ),
                  );
                } catch (e) {}
              },),
            ],
          ),
        ),
      ),
    );
  }
}
