import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_reminder/firebase_servies/google_serviec.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/common_button.dart';
import '../../constants/common_text.dart';
import '../../constants/getx_controllers.dart';
import '../../firebase_servies/email_serviec.dart';
import '../navbar_view/bottom_navigation_bar.dart';
var signupname = TextEditingController();
var signupemail = TextEditingController();
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  void initState() {
    signupemail = TextEditingController();
    password = TextEditingController();
    signupname = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    signupemail.dispose();
    password.dispose();
    signupname.dispose();
    super.dispose();
  }

  final _email = GlobalKey<FormState>();
  final _password = GlobalKey<FormState>();
  final _name = GlobalKey<FormState>();


  var password = TextEditingController();
  helathController helathcontroller=Get.put(helathController());

  bool select = true;
  bool _isverify = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width*0.06,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: Get.height*0.05,
              ),
              Text(
                "Please enter your details to enter\nthe app",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width*0.055,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Get.height*0.05,
              ),
              Container(
                height: Get.height*0.73,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width*0.06))),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:  Get.width*0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height :Get.height*0.04,
                        ),
                        Text(
                          "Username",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:  Get.width*0.05),
                        ),
                        SizedBox(
                          height :Get.height*0.02,
                        ),
                        Form(
                          key: _name,
                          child: Comman_tax(
                            obscur: false,
                            contro: signupname,
                            hint: "Please enter your username",
                            onchage: (value) {
                              _name.currentState!.validate();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please valid username enter";
                              }
                            },
                            ontap: () {},
                          ),
                        ),
                        SizedBox(
                          height: Get.height*0.02,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width*0.05),
                        ),
                        SizedBox(
                          height :Get.height*0.02,
                        ),
                        Form(
                          key: _email,
                          child: Comman_tax(
                            obscur: false,
                            contro: signupemail,
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
                        Text(
                          "Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width*0.05),
                        ),
                        SizedBox(
                          height :Get.height*0.02,
                        ),
                        Form(
                          key: _password,
                          child: Comman_tax(
                            obscur: select,
                            hint: "Please enter your password",
                            sufix: InkWell(
                              onTap: () {
                                setState(() {
                                  select = !select;
                                });
                              },
                              child: select == false
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                            ),
                            contro: password,
                            onchage: (value) {
                              _password.currentState!.validate();
                            },
                            validator: (value) {
                              final bool passwordvalid = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(value!);

                              if (passwordvalid) {
                                return null;
                              } else {
                                return "please valid password enter";
                              }
                            },
                            ontap: () {},
                          ),
                        ),
                        SizedBox(
                          height:Get.height*0.05,
                        ),
                        _isverify == false
                            ? material().button(
                                text: "Sign up",
                                ontap: () {
                                  if (_name.currentState!.validate() &&
                                      _email.currentState!.validate() &&
                                      _password.currentState!.validate()) {
                                    setState(() {
                                      _isverify = true;
                                    });
                                    EmailAuthServices.signUpUser(
                                            name: signupname.text,
                                            email: signupemail.text,
                                            password: password.text)
                                        .then((value) async {
                                      if (value != null) {

                                        SharedPreferences sharedPreferences =
                                            await SharedPreferences.getInstance();
                                        await sharedPreferences.setString('name', signupname.text);
                                        await sharedPreferences.setString('email', signupemail.text);

                                        Get.off(Navigator_bar());

                                      } else {
                                        setState(() {
                                          _isverify = false;
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.grey.shade900,
                                                content: Text(
                                                    "Email is already in use by another accoount",style: TextStyle(color: Colors.white),)));
                                      }
                                    });
                                  }
                                })
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                        SizedBox(
                          height:Get.height*0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Or",
                              style:
                                  TextStyle(fontSize:Get.width*0.04, color: Colors.black),
                            ),
                          ],
                        ),
                       Center(
                         child: InkWell(
                           onTap: () {
                              googleservice
                                  .signInWithGoogle()
                                  .then((value) async {
                                if (value != null) {
                                  SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                                  pref
                                      .setString('email', signupemail.text)
                                      .then((value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Navigator_bar(),
                                      )));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.grey.shade900,
                                          content: Text(
                                            "Email is already in use by another accoount",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )));
                                }
                              });
                            },
                           child: Container(
                             height: Get.height*0.14,
                             width: Get.width*0.14,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               shape: BoxShape.circle,
                               boxShadow: [
                                 BoxShadow(
                                   blurRadius: 0.5,
                                   spreadRadius: 0.5,
                                   color: Colors.grey.shade400,
                                 ),
                               ]
                             ),
                             child: Lottie.asset("images/38870-google-logo-effect.json"),
                           ),
                         ),
                       )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

