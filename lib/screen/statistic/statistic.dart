import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'active_screen.dart';
import 'complete_screen.dart';


class Static_page extends StatefulWidget {
  const Static_page({Key? key}) : super(key: key);

  @override
  State<Static_page> createState() => _Static_pageState();
}

class _Static_pageState extends State<Static_page>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List list = ["Active", "Complete"];
  int select = 0;
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    tabController!.addListener(() {
      setState(() {
        select = tabController!.index;
      });
      print("Selected Index: " + tabController!.index.toString());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Statistic",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: Get.width*0.065,
                ),
              ),
              SizedBox(
                height: Get.height*0.04,
              ),
              Center(
                child: TabBar(
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorColor: Colors.transparent,
                  onTap: (value) {
                    setState(() {
                      select = value;
                    });
                  },
                  tabs: List.generate(
                      2,
                          (index) => Container(
                        height: Get.height*0.05,
                        width: Get.width*0.45,
                        margin: EdgeInsets.only(right: 10,),
                        child: Center(
                          child: Text(
                            list[index],
                            style: TextStyle(
                                fontSize: Get.width*0.04,
                                color: select == index
                                    ? Colors.white
                                    : Colors.grey.shade800),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: select != index
                                ? Colors.grey.shade300
                                : Colors.teal.shade400,
                            borderRadius: BorderRadius.circular(14)),
                      )),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Active_page(),
                    COMPLETE_SCREEN(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
