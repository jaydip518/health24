import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/model/onbording.dart';
import 'package:medicine_reminder/screen/welcome_signup_view/welcome_sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class helathController extends GetxController{
  List<Onbording> list=[
    Onbording('images/image1.png', 'Reception drug',  'Add,edit,track admission your drugs\nin two clicks.Making a drug from\nyour phone is as easy.'),
    Onbording('images/image2.png', 'Monitoring health',  'View history your well-being after\ndrug in one clickCommon Review Mission  Monitoring Reports.'),
    Onbording('images/image3.png', 'Get notified', 'Our system will your of all does of the drug,so you do not have to keep everything in your mind.'),
  ];
  String? username;
  bool get isLastpage=> selectedpage.value==list.length-1;
  var selectedpage=0.obs;
  var pageController=PageController();
  var select = true;
  var isverify = false;
  String? Age;
  String? Height;
  var storvalue=0.obs;
  var isProfilePathset=false.obs;
  var profilepath="".obs;

  var user=GetModel().obs;



  getuserInfo(){
    String uid=FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).collection('profile').doc(uid).snapshots().listen((event) {
      user.value=GetModel.fromMap(event.data()!);
    });
    update();
  }

  void setprofileImagepath(String path){
    profilepath.value=path;
    isProfilePathset.value=true;
  }


  void getusername(String name){
    username=name;
    update();
  }

  forwardAction(){
    if(isLastpage){
      Get.off(WELCOME_SIGNUP());
    }else {
      pageController.nextPage(
          duration: 300.milliseconds, curve: Curves.bounceIn);
    }
  }

   agecounter(String value){
    Age=value;
    update();
  }
  heightcounter(String value){
    Height=value;
    update();
  }

}