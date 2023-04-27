import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../add_medicine/add_medicine.dart';
import '../helath_monitoring/health_monitering.dart';
import '../helath_monitoring/helath.dart';
import '../home_view/homeview.dart';
import '../statistic/statistic.dart';
import '../video_view/video.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  List select = [
    Homeview(),
    Helath(),
    AddMedicins(),
    Static_page(),
    VIDEO(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: ClipRRect(
        //borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          // backgroundColor: Colors.teal.shade400,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          backgroundColor: Colors.black87,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          mouseCursor: MouseCursor.defer,
          elevation: 100,
          items: [
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  Icons.home_filled,
                  size: Get.height*0.035,
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  size: Get.height*0.035,
                  Icons.motion_photos_on_sharp,
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  Icons.add,
                  size: Get.height*0.035,
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  size: Get.height*0.035,
                  Icons.bar_chart,
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  size: Get.height*0.035,
                  Icons.video_collection,
                )),
          ],
        ),
      ),
      body: select[_selectedIndex],
    );
  }
}
