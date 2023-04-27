import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_reminder/firebase_servies/google_serviec.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/common_button.dart';
import '../../constants/common_text.dart';
import '../../constants/getx_controllers.dart';
import '../../firebase_servies/email_serviec.dart';
import '../navbar_view/bottom_navigation_bar.dart';
import '../welcome_signup_view/forgot.dart';

var signemail = TextEditingController();
var signpassword = TextEditingController();

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  void initState() {
    signemail = TextEditingController();
    signpassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    signemail.dispose();
    signpassword.dispose();
    super.dispose();
  }

  final _email = GlobalKey<FormState>();
  final _password = GlobalKey<FormState>();

  helathController helathcontroller = Get.put(helathController());

  // bool select = true;
  bool _isverify = false;
  bool select = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Text(
                "Welcome back please enter your details to enter in app",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width * 0.055,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Container(
                height: Get.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Get.width * 0.06))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.05),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Form(
                          key: _email,
                          child: Comman_tax(
                            obscur: false,
                            contro: signemail,
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
                              fontSize: Get.width * 0.05),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
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
                            contro: signpassword,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Forget_Screen(),
                                      ));
                                },
                                child: Text(
                                  "Forget password?",
                                  style: TextStyle(color: Colors.red),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        _isverify == false
                            ? material().button(
                                text: "Sign In",
                                ontap: () {
                                  if (_email.currentState!.validate() &&
                                      _password.currentState!.validate()) {
                                    setState(() {
                                      _isverify = true;
                                    });
                                    EmailAuthServices.loginUser(
                                            email: signemail.text,
                                            password: signpassword.text)
                                        .then((value) async {
                                      if (value != null) {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        pref
                                            .setString('email', signemail.text)
                                            .then((value) =>
                                                Get.off(Navigator_bar()));
                                      } else {
                                        setState(() {
                                          _isverify = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Colors.grey.shade900,
                                                content: Text(
                                                  "Email is already in use by another accoount",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )));
                                      }
                                    });
                                  }
                                })
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Or",
                              style: TextStyle(
                                  fontSize: Get.width * 0.04,
                                  color: Colors.black),
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
                                      .setString('email', signemail.text)
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
                              height: Get.height * 0.14,
                              width: Get.width * 0.14,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5,
                                      color: Colors.grey.shade400,
                                    ),
                                  ]),
                              child: Lottie.asset(
                                  "images/38870-google-logo-effect.json",
                              ),
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
