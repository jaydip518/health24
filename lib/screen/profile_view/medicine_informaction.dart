import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MEDICINE_INFORMCTION extends StatefulWidget {
  const MEDICINE_INFORMCTION({Key? key}) : super(key: key);

  @override
  State<MEDICINE_INFORMCTION> createState() => _MEDICINE_INFORMCTIONState();
}

class _MEDICINE_INFORMCTIONState extends State<MEDICINE_INFORMCTION> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("medecine informatcion"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
        leading: InkWell(onTap: () {
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('medecine')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final medicine = snapshot.data!.docs;
                      return ListView.builder(
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
                            child: ListTile(
                              leading: Icon(
                                Icons.health_and_safety,
                                color: Colors.white,
                              ),
                              title: Text(
                                medicine[index].get('medicineName'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                medicine[index].get('desc'),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal,
                          ));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
