import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/constants/common_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/common_button.dart';

class REPORT_BUG extends StatefulWidget {
  const REPORT_BUG({Key? key}) : super(key: key);

  @override
  State<REPORT_BUG> createState() => _REPORT_BUGState();
}

class _REPORT_BUGState extends State<REPORT_BUG> {
  var ebug = TextEditingController();
  var disc = TextEditingController();
  final _ebug = GlobalKey<FormState>();
  final _dis = GlobalKey<FormState>();
  bool showPassword = false;
  ImagePicker imagePicker1 = ImagePicker();
  File? image;
  bool sel = false;
  choseimage() async {
    final file = await imagePicker1.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
  }

  @override
  void dispose() {
    ebug.clear();
    disc.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        actions: [
          IconButton(
              onPressed: () {
                launch('mailto:medicinhealth@gmail.com');
              },
              icon: Icon(Icons.send))
        ],
        title: Text('Report a bug'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _ebug,
                child: Comman_tax(
                  obscur: false,
                  contro: ebug,
                  hint: "Enter your Email",
                  onchage: (value) {
                    _ebug.currentState!.validate();
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
                height: Get.height*0.03,
              ),
              Comman_tax(
                ontap: () {},
                obscur: false,
                contro: disc,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Discriptions";
                  }
                },
                onchage: (value) {
                  _dis.currentState!.validate();
                },
                hint:
                "Please be as detailed as possible.What did you expect and what happened instead?",
              ),
              SizedBox(
                height: Get.height*0.04,
              ),
              Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: Get.width*0.26,
                  height: Get.height*0.12,
                  child: image == null
                      ? InkWell(
                    onTap: () async {
                      setState(() {
                        choseimage();
                      });
                    },
                    child: Icon(
                      Icons.image,
                      size: 55,
                    ),
                  )
                      : Image.file(
                    image!,
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                    top: -13,
                    right: -7,
                    child: Container(
                      height: Get.height*0.05,
                      width: Get.width*0.06,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal.shade400,
                      ),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => REPORT_BUG(),
                                ));
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: Get.height*0.025,
                          )),
                    )),
              ]),
              SizedBox(
                height: Get.height*0.04,
              ),
              material().button(
                text: "Submit",
                ontap: () {
                  if (_ebug.currentState!.validate()) {
                    Navigator.pop(context);
                    ebug.clear();
                    disc.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Successful Submit",
                        style: TextStyle(
                            fontSize: Get.width*0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ));
                  } else {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
