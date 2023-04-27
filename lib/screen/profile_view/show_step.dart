import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SHOW_STEP extends StatefulWidget {
  const SHOW_STEP({Key? key}) : super(key: key);

  @override
  State<SHOW_STEP> createState() => _SHOW_STEPState();
}

class _SHOW_STEPState extends State<SHOW_STEP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('step')
              .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final helath = snapshot.data!.docs;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.04),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*0.04,),
                      InkWell(onTap: () {
                        Navigator.pop(context);
                      },child: Icon(Icons.arrow_back)),
                      SizedBox(height:Get.height*0.04),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: helath.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: Get.height*0.22,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade400,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width*0.05, vertical: Get.height*0.03),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Step ${helath[index].get('score')}",
                                        style: TextStyle(
                                            color: Colors.white,fontSize: Get.width*0.05,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: Get.height*0.03,),
                                      Text("km ${helath[index].get('km')}",style: TextStyle(
                                          color: Colors.white,fontSize: Get.width*0.045,
                                          fontWeight: FontWeight.w600),),
                                      SizedBox(height: Get.width*0.02,),
                                      Text("goalkm ${helath[index].get('goalkm')}",style: TextStyle(
                                          color: Colors.white,fontSize: Get.width*0.045,
                                          fontWeight: FontWeight.w600),),
                                      SizedBox(height: Get.width*0.02,),
                                      Text("kcal ${helath[index].get('kcal')}",style: TextStyle(
                                          color: Colors.white,fontSize: Get.width*0.045,
                                          fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 13,
                            mainAxisExtent: Get.width*0.5,
                            mainAxisSpacing: 15),
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
