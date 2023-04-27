import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/constants/common_text.dart';
import 'package:medicine_reminder/screen/video_view/video.dart';
import 'package:share_plus/share_plus.dart';

class OptionsScreen extends StatefulWidget {
  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  bool isfav = false;
  int counter = 0;
  var value="";
  int count=0;
  TextEditingController text=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 110),
                  Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person, size: 18),
                        radius: 16,
                      ),
                      SizedBox(width: 6),
                      Text('flutter_developer02'),
                      SizedBox(width: 10),
                      Icon(Icons.verified, size: 15),
                      SizedBox(width: 6),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isfav = !isfav;
                          if (isfav == true) {
                            counter++;
                          } else {
                            counter--;
                          }
                        });
                      },
                      icon: isfav == true
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_border,
                            )),
                  Text("${counter}"),
                  SizedBox(height: Get.height*0.01),
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: Get.height*0.5,
                            width: double.infinity,
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.03),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text("Comments",style: TextStyle(fontSize: Get.width*0.03),),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          child: Icon(Icons.person, size: 18),
                                          radius: 16,
                                        ),
                                        SizedBox(width: 6),
                                        Text('flutter_developer02'),
                                        SizedBox(width: 10),
                                        Icon(Icons.verified, size: 15),
                                        SizedBox(width: 6),
                                        TextButton(
                                          onPressed: () {
                                          },
                                          child: Text(
                                            'Follow',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height*0.03,
                                    ),
                                    Comman_tax(ontap: () {

                                    }, contro: text,obscur: false,hint: "Add comment",contentPadding: EdgeInsets.all(10),),
                                    SizedBox(
                                      height: Get.height*0.03,
                                    ),
                                    MaterialButton(onPressed: () {
                                      Navigator.pop(context);
                                    },child: Text("Post"),color: Colors.teal.shade400,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.comment_rounded)),
                  SizedBox(height: Get.height*0.03),
                  InkWell(child: Icon(Icons.send),onTap: () {
                    Share.share("Video");
                  },),
                  SizedBox(height: Get.height*0.03),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
