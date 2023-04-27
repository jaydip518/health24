import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AGE_CALCULATE extends StatefulWidget {
  final Function(int) onchange;
  final String title;
  final int invalue;
  final int min;
  final int max;
  const AGE_CALCULATE({Key? key, required this.onchange, required this.title, required this.invalue, required this.min, required this.max}) : super(key: key);

  @override
  State<AGE_CALCULATE> createState() => _AGE_CALCULATEState();
}

class _AGE_CALCULATEState extends State<AGE_CALCULATE> {
  int counter1=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counter1=widget.invalue;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*0.1,
      child: Card(
        color: Colors.white,
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:  Get.width*0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.title,style: TextStyle(fontSize: Get.width*0.04 ,color:Color(0xff555555)),),
              SizedBox(height:  Get.height*0.01,),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if(counter1>widget.min){
                          counter1--;
                        }
                      });
                      widget.onchange(counter1);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.teal.shade400,
                      radius:  Get.width*0.04,
                      child: Icon(Icons.remove,color: Colors.white,),
                    ),
                  ),
                  SizedBox(width: Get.width*0.07,),
                  Text(counter1.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: Get.width*0.05,color: Color(0xff555555)),),
                  SizedBox(width: Get.width*0.07,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if(counter1<widget.max){
                          counter1++;
                        }
                      });
                      widget.onchange(counter1);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.teal.shade400,
                      radius:  Get.width*0.04,
                      child: Icon(Icons.add,color: Colors.white,),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
