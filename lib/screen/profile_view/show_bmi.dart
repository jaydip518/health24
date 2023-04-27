import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SHOW_BMI extends StatefulWidget {
  const SHOW_BMI({Key? key}) : super(key: key);

  @override
  State<SHOW_BMI> createState() => _SHOW_BMIState();
}

class _SHOW_BMIState extends State<SHOW_BMI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('bmi')
              .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final medicine = snapshot.data!.docs;
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*0.04,),
                      InkWell(onTap: () {
                        Navigator.pop(context);
                      },child: Icon(Icons.arrow_back)),
                      SizedBox(height: Get.height*0.03,),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: medicine.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: Get.height*0.1,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.teal.shade400,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.symmetric(vertical: Get.width*0.02),
                            child: Padding(
                              padding:  EdgeInsets.only(top: Get.width*0.02),
                              child: ListTile(
                                leading: Icon(Icons.person_search_outlined),
                                title: Text(
                                  "BMI\n${medicine[index].get('bmi')}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Get.width*0.045,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }else{
              return Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ));
            }
          },
        ),
      ),
    );
  }
}
