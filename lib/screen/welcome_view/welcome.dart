import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/constants/getx_controllers.dart';

class Welcome extends StatefulWidget {

  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {


  helathController helathcontroller=Get.put(helathController());
  @override
  void initState() {
    helathcontroller.pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    helathcontroller.pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: Get.height*0.1),
          child: Column(
            children: [
              SizedBox(
                height: Get.height*0.52,
                child: PageView.builder(
                  controller: helathcontroller.pageController,
                  onPageChanged: helathcontroller.selectedpage,
                  itemCount: helathcontroller.list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.1),
                      child: Column(
                        children: [
                          Image.asset(
                            helathcontroller.list[index].image,
                            height: Get.height*0.3,
                          ),
                          SizedBox(
                            height: Get.height*0.02,
                          ),
                          Text(
                            helathcontroller.list[index].title,
                            style: TextStyle(
                                fontSize: Get.width*0.08,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height:Get.height*0.05,
                          ),
                          Text(
                            helathcontroller.list[index].desc,
                            style: TextStyle(fontSize: Get.height*0.022, color:Colors.white,),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height:Get.height*0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                        (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.01),
                      child: Obx(() => CircleAvatar(
                        backgroundColor: helathcontroller.selectedpage.value == index
                            ? Colors.teal.shade400
                            : Colors.grey,
                        maxRadius: 3.5,
                      ),)
                    )),
              ),
              SizedBox(
                height: Get.height*0.1,
              ),
              MaterialButton(
                onPressed: () {
                  helathcontroller.forwardAction();
                },
                child: Obx(() => Text(
                  helathcontroller.isLastpage? "Get Started" : "Next",
                  style: TextStyle(color: Colors.white, fontSize: Get.width*0.04),
                ),),
                minWidth: Get.width*0.8,
                height: Get.height*0.06,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.teal.shade400,
              )
            ],
          ),
        ),
      ),
    );
  }
}
