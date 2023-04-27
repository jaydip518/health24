import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/screen/splash_view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/theme_mod.dart';
import 'model/shar_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.teal.shade400,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Helath24',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
        ),
      ),
      darkTheme: MyThemes.dark,
      themeMode: ThemeMode.dark,
      home: SPLASH_SCREEN(),
    );
  }
}


