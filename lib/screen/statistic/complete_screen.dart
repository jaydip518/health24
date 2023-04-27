import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class COMPLETE_SCREEN extends StatefulWidget {
  const COMPLETE_SCREEN({Key? key}) : super(key: key);

  @override
  State<COMPLETE_SCREEN> createState() => _COMPLETE_SCREENState();
}

class _COMPLETE_SCREENState extends State<COMPLETE_SCREEN> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('achieve')
              .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final medicine = snapshot.data!.docs;
              return  Padding(
                padding:  EdgeInsets.symmetric(vertical: Get.height*0.04),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: medicine.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: Get.height*0.25,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height*0.1,
                                  ),
                                  Text(
                                    medicine[index].get('medicineName'),
                                    style: TextStyle(
                                        fontSize: Get.width*0.05,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: Get.height*0.02,
                                  ),
                                  Text(
                                    medicine[index].get('desc'),
                                    style: TextStyle(
                                        fontSize: Get.width*0.035,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: Get.height*0.02,
                                  ),
                                  Center(
                                    child: Container(
                                      height: Get.height*0.035,
                                      width: Get.width*0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(14)),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }else{
              return Center(child: CircularProgressIndicator(color: Colors.teal,));
            }
          },
        ),
      ),
    );
  }
}
