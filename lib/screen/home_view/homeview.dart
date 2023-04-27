import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/constants/getx_controllers.dart';
import '../profile_view/MYHEALTH.dart';
import '../profile_view/about_us.dart';
import '../profile_view/chat_gpt_screen.dart';
import '../profile_view/community_screen.dart';
import '../profile_view/logout.dart';
import '../profile_view/medicine_informaction.dart';
import '../profile_view/my_report.dart';
import '../profile_view/setting.dart';

TextEditingController _name = TextEditingController();
TextEditingController _desc = TextEditingController();

final storage = GetStorage();

class Homeview extends StatefulWidget {
  const Homeview({Key? key}) : super(key: key);

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  List items = [
    {
      'icon': Icons.chat,
      'title': 'Chat With Doctor',
    },
    {
      'icon': Icons.medical_information,
      'title': 'My Medicine',
    },
    {
      'icon': Icons.local_hospital,
      'title': 'My Health',
    },
    {
      'icon': Icons.assessment,
      'title': 'My Report',
    },
    {
      'icon': Icons.settings,
      'title': 'Settings',
    },
    {
      'icon': Icons.groups_outlined,
      'title': 'Community',
    },
    {
      'icon': Icons.info,
      'title': 'About',
    },
    {
      'icon': Icons.logout,
      'title': 'logout',
    },
  ];

  List screen = [
    ChatGptScreen(),
    MEDICINE_INFORMCTION(),
    MYHEALTH(),
    MY_REPORT(),
    SETTINGS(),
    COMUNITY_SCREEN(),
    ABOUT_US_SCREEN(),
    LOGOUT(),
  ];

  @override
  void initState() {
    helathcontroller.getuserInfo();
    super.initState();
  }

  DateTime _dateTime = DateTime.now();
  List<String> poplist = ["Edit", "Remove"];

  dynamic value;
  final globelkey = GlobalKey<ScaffoldState>();

  dynamic isCompleted = 0;

  helathController helathcontroller = Get.find<helathController>();

  File? _image = null;
  late final _picker = ImagePicker();

  Future getImagebyGallery(context) async {
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);
    setState(
      () {
        if (image != null) {
          _image = File(image.path);
          storage.write('image', image.path);
        }
        Navigator.pop(context);
      },
    );
  }

  Future getImagebyCamera() async {
    final PickedFile? image =
        await _picker.getImage(source: ImageSource.camera);
    setState(
      () {
        if (image != null) {
          _image = File(image.path);
          storage.write('image', image.path);
        }
        Navigator.pop(context);
      },
    );
  }
  List tax = [
    {
      'title':"Heart rate",
      'subtitle':"95%"
    },
    {
      "title": "Water",
      "subtitle": "50%",
    },
    {
      "title": "Bmi",
      "subtitle": "80%",
    },
    {
      "title": "Steps",
      "subtitle": "50%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globelkey,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.03, vertical: Get.height * 0.026),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5)),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 41,
                        child: storage.read('image') == null
                            ? CircleAvatar(
                                child: InkWell(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 150,
                                  ),
                                  onTap: () => getImage(context),
                                ),
                              )
                            : Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(storage.read('image'))),
                                    radius: 50,
                                  ),
                                  Positioned(
                                      bottom: -1,
                                      right: -1,
                                      child: GestureDetector(
                                        onTap: () => getImage(context),
                                        child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 0.2,
              ),
              Column(
                children: List.generate(
                    screen.length,
                    (index) => InkWell(
                          onTap: () {
                            setState(() {
                              screen == index;
                              Get.to(screen[index]);
                            });
                          },
                          child: ListTile(
                            title: Text(
                              items[index]['title'],
                            ),
                            leading: Icon(
                              items[index]['icon'],
                              color: Colors.white,
                            ),
                          ),
                        )),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            globelkey.currentState!.openDrawer();
                          });
                        },
                        child: Icon(Icons.menu,size: Get.height*0.03,)),
                    Text(
                      "Your Medicine",
                      style: TextStyle(
                          fontSize: Get.height * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                        "${_dateTime.year}/${_dateTime.month}/${_dateTime.day}"),
                  ],
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('medecine')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final medicine = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: medicine.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                                title: "Activity",
                                content: const Text(
                                  "Your Medicine",
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  Container(
                                    height: Get.height * 0.15,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          onPressed: () async {
                                            _name = TextEditingController(
                                              text: medicine[index]
                                                  .get('medicineName'),
                                            );
                                            _desc = TextEditingController(
                                                text: medicine[index]
                                                    .get('desc'));
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .collection('achieve')
                                                .add({
                                              'medicineName': _name.text,
                                              'desc': _desc.text,
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text("Achieve"),
                                          height: Get.height * 0.05,
                                          minWidth: Get.width * 0.5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          color: Colors.teal,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                          height: Get.height * 0.05,
                                          minWidth: Get.width * 0.5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  )
                                ]);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.035),
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.01),
                                padding: EdgeInsets.only(top: Get.width * 0.01),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.06),
                                      child: Center(
                                          child: Icon(
                                        Icons.health_and_safety,
                                        size: Get.height * 0.04,
                                      )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02,
                                          horizontal: Get.width * 0.035),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            medicine[index].get('medicineName'),
                                            style: TextStyle(
                                                fontSize: Get.width * 0.05),
                                          ),
                                          SizedBox(
                                            height: Get.width * 0.01,
                                          ),
                                          Text(
                                            medicine[index].get('desc'),
                                            style: TextStyle(
                                                fontSize: Get.width * 0.04),
                                          ),
                                          SizedBox(
                                            height: Get.width * 0.01,
                                          ),
                                          Text(
                                            medicine[index].get('Time'),
                                            style: TextStyle(
                                                fontSize: Get.width * 0.04),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onSelected: (value) {
                                        if (value == "Edit") {
                                          _name = TextEditingController(
                                            text: medicine[index]
                                                .get('medicineName'),
                                          );
                                          _desc = TextEditingController(
                                              text:
                                                  medicine[index].get('desc'));
                                          Get.defaultDialog(
                                            title: "Your Medicine",
                                            titleStyle: const TextStyle(
                                                color: Colors.white),
                                            content: const Text(
                                              "Update Medicine",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            actions: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Get.width *
                                                                    0.03),
                                                    child: TextFormField(
                                                      controller: _name,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      decoration: const InputDecoration(
                                                          hintText: "Title",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white))),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.01,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Get.width *
                                                                    0.03),
                                                    child: TextFormField(
                                                      controller: _desc,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      decoration: const InputDecoration(
                                                          hintText: "Desc",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white))),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              MaterialButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .collection('medecine')
                                                      .doc(medicine[index].id)
                                                      .update({
                                                    'medicineName': _name.text,
                                                    'desc': _desc.text,
                                                  });
                                                  Navigator.pop(context);
                                                  _name.clear();
                                                  _desc.clear();
                                                },
                                                color: Colors.teal.shade400,
                                                child: const Text("Update",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              MaterialButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                color: Colors.red,
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else if (value == "Remove") {
                                          Get.defaultDialog(
                                              title: "Your Medicine",
                                              titleStyle: const TextStyle(
                                                  color: Colors.white),
                                              content: const Text(
                                                "You have delete the Medicine",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              actions: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .collection('medecine')
                                                        .doc(medicine[index].id)
                                                        .delete();
                                                    Navigator.pop(context);
                                                    _name.clear();
                                                    _desc.clear();
                                                  },
                                                  color: Colors.teal.shade400,
                                                  child: const Text("Yes",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                                MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  color: Colors.red,
                                                  child: const Text(
                                                    "No",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ]);
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return poplist
                                            .map((e) => PopupMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ))
                                            .toList();
                                      },
                                    ),
                                  ],
                                ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(
                      child: const Text(
                    "no data found",
                    style: TextStyle(color: Colors.white),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: Get.height * 0.2,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  "Select Image",
                  style: TextStyle(fontSize: Get.width * 0.045),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => getImagebyGallery(context),
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: Image.asset(
                                "images/gallery.png",
                                height: Get.height * 0.06,
                              )),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => getImagebyCamera(),
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: Image.asset("images/camera.png",
                                  height: Get.height * 0.06)),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
