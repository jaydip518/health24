import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Active_page extends StatefulWidget {
  const Active_page({Key? key}) : super(key: key);

  @override
  State<Active_page> createState() => _Active_pageState();
}

class _Active_pageState extends State<Active_page> {
  List tax = [
    {
      "tax": "Cinupret",
      "tax1": "19.06.22- 19-07-22",
    },
    {
      "tax": "Orthomol",
      "tax1": "19.06.22-19-07-22",
    },
    {
      "tax": "Centrum",
      "tax1": "19.06.22-19-07-22",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('medecine')
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
                                    medicine[index].get('Reminder'),
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
