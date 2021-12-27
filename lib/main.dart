import 'package:arboretumproperties/admin_panel/adminpanel_mainpage.dart';
import 'package:arboretumproperties/constant.dart';
import 'package:arboretumproperties/login_signup/login.dart';
import 'package:arboretumproperties/main_categories.dart';
import 'package:arboretumproperties/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(ArboretumProperties());

class ArboretumProperties extends StatelessWidget {
  const ArboretumProperties({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'main page',
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        MAIN_CATEGORIES: (BuildContext context) => MainCategories(),
        LOGIN: (BuildContext context) => Login(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return MainCategories();
          }
          return SplashScreen();
        },
      ),
    );
  }
}