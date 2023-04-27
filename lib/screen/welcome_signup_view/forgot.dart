import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/firebase_servies/google_serviec.dart';

import '../../constants/common_button.dart';
import '../../constants/common_text.dart';
import '../../firebase_servies/email_serviec.dart';

class Forget_Screen extends StatefulWidget {
  const Forget_Screen({Key? key}) : super(key: key);

  @override
  State<Forget_Screen> createState() => _Forget_ScreenState();
}

class _Forget_ScreenState extends State<Forget_Screen> {
  final _email = GlobalKey<FormState>();
  var email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _email,
              child: Comman_tax(
                obscur: false,
                contro: email,
                hint: "Please enter your email",
                onchage: (value) {
                  _email.currentState!.validate();
                },
                validator: (value) {
                  final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);
                  if (emailValid) {
                    return null;
                  } else {
                    return "please valid email enter";
                  }
                },
                ontap: () {},
              ),
            ),
            SizedBox(
              height: Get.height*0.02,
            ),
            material().button(
              text: "Forget password",
              ontap: () {
                EmailAuthServices.ForgetUser(email: email.text)
                    .then((value) {
                      if(value==null){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                            backgroundColor: Colors.grey.shade900,
                            content: Text(
                              "Please check your gmail",
                              style:
                              TextStyle(color: Colors.white),
                            )));
                        Get.back();
                      }else{
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                            backgroundColor: Colors.grey.shade900,
                            content: Text(
                              "Error",
                              style:
                              TextStyle(color: Colors.white),
                            )));
                      }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
