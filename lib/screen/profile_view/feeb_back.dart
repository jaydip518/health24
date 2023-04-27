import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FEED_BACK extends StatefulWidget {
  const FEED_BACK({Key? key}) : super(key: key);

  @override
  State<FEED_BACK> createState() => _FEED_BACKState();
}

class _FEED_BACKState extends State<FEED_BACK> {
  List _varibal = ["", "Terrible", "Bad", "Good", "Very good", "Awesome"];
  double _slect = 0;
  List _options = [
    "Terrible",
    "Bad",
    "Good",
    "Very Good",
    "Awesome",
    "No Saggation",
  ];
  var sel = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: Text("Give Feedback"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height*0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                    (index) => Center(
                    child: Center(
                      child: Text(
                        _slect == index ? _varibal[index] : "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width*0.04,
                        ),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: Get.height*0.02,
            ),
            Center(
                child: RatingBar.builder(
                  minRating: 1,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      _slect = value;
                    });
                    print(_slect);
                  },
                )),
            SizedBox(
              height:Get.height*0.02,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: Get.height*0.01,
            ),
            Container(
              height: Get.height*0.35,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          sel = index;
                        });
                      },
                      child: Container(
                        height: Get.height*0.05,
                        width: Get.width*0.04,
                        child: Center(
                          child: Text(
                            _options[index],
                            style: TextStyle(
                                fontSize: Get.width*0.04,
                                color: sel != index ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        margin: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: sel != index ? Colors.white : Colors.teal,
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            sel == index
                                ? BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: Colors.tealAccent.shade200,
                                offset: Offset(1, 1))
                                : BoxShadow(),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: Get.height*0.02,
            ),
            Text(
              "This rating won't apply to your driver",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Get.width*0.045),
            ),
            SizedBox(
              height:Get.height*0.04,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FEED_BACK(),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Successful Submit",
                    style: TextStyle(
                        fontSize: Get.width*0.04,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ));
              },
              color: Colors.red,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              height: Get.height*0.06,
              minWidth: Get.width*0.8,
              child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width*0.045),
              ),
            )
          ],
        ),
      ),
    );
  }
}
