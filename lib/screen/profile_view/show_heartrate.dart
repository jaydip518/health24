import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SHOW_HEARTRATE extends StatefulWidget {
  const SHOW_HEARTRATE({Key? key}) : super(key: key);

  @override
  State<SHOW_HEARTRATE> createState() => _SHOW_HEARTRATEState();
}

class _SHOW_HEARTRATEState extends State<SHOW_HEARTRATE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('hartrate')
              .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final medicine = snapshot.data!.docs;
              return Padding(
                padding:  EdgeInsets.symmetric(vertical: Get.height*0.03,horizontal: Get.width*0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(onTap: () {
                        Navigator.pop(context);
                      },child: Icon(Icons.arrow_back)),
                      SizedBox(height: Get.height*0.03,),
                      ListView.builder(
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
                                leading: Icon(Icons.favorite),
                                title: Text(
                                  "Heart rate\n${medicine[index].get('heartrate')}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Get.width*0.05,
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
