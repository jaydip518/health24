import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SHOW_WATER extends StatefulWidget {
  const SHOW_WATER({Key? key}) : super(key: key);

  @override
  State<SHOW_WATER> createState() => _SHOW_WATERState();
}

class _SHOW_WATERState extends State<SHOW_WATER> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('water')
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
                      SizedBox(height: Get.height*0.03,),
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
                            margin: EdgeInsets.symmetric(vertical: Get.height*0.01),
                            child: Padding(
                              padding:  EdgeInsets.only(top: Get.height*0.01),
                              child: ListTile(
                                leading: Icon(Icons.timelapse),
                                title: Text(
                                  "Reminder time\n${medicine[index].get('Time')}",
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
