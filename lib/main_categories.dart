import 'dart:io';

import 'package:arboretumproperties/ChatScreens/all_chats_screen.dart';
import 'package:arboretumproperties/Student_rooms.dart/student_nav.dart';
import 'package:arboretumproperties/admin_panel/adminpanel_mainpage.dart';
import 'package:arboretumproperties/admin_panel/inbox/messages.dart';
import 'package:arboretumproperties/apartments/apartment_nav.dart';
import 'package:arboretumproperties/professional_rooms/professional_nav.dart';
import 'package:arboretumproperties/services/pushNotificationService.dart';
import 'package:arboretumproperties/short_term_stay/short_term_stay_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'login_signup/login.dart';

class MainCategories extends StatefulWidget {
  MainCategories({Key key}) : super(key: key);

  @override
  _MainCategoriesState createState() => _MainCategoriesState();
}

class _MainCategoriesState extends State<MainCategories> {

  bool _prefloading = false;
  String currentUserId;

//  FirebasePushNotificationService _pushNotificationService;

  @override
  void initState() {
    final FirebaseMessaging _fcm = FirebaseMessaging();
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    _fcm.subscribeToTopic('offers');
//    _pushNotificationService = FirebasePushNotificationService();
//    _pushNotificationService.initialize();
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _prefloading = true;
      });
      FirebaseUser authResult = await FirebaseAuth.instance.currentUser();
      setState(() {
        currentUserId = authResult.uid;
        _prefloading = false;
        print(currentUserId);
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body:_prefloading == true
          ?new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/abg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ):  StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/abg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(child: CircularProgressIndicator(),),
            );
          }
          if(snapshot.data['admin']!=null && snapshot.data['admin'] == true)
            return AdminPanelMainPage(snapshot);
          return new Stack(
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/abg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: ListView(
                  children: [
                    // SizedBox(
                    //   height: 30,
                    // ),
                    Container(
                      width: 160,
                      height: 160,
                      child: Image(
                        image: AssetImage('assets/whitelogo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.grey[300],
                      textColor: Colors.black,
                      child: Text("STUDENT ROOMS",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentNavigationBar(snapshot)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.grey[300],
                      textColor: Colors.black,
                      child: Text("PROFESSIONAL ROOMS",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfessionalNavigationBar(snapshot)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.grey[300],
                      textColor: Colors.black,
                      child: Text("SHORT TERM STAY",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShortTermStayNavigationBar(snapshot)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.grey[300],
                      textColor: Colors.black,
                      child: Text("APARTMENTS",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ApartmentNavigationBar(snapshot)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),RaisedButton(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.grey[300],
                      textColor: Colors.black,
                      child: Text("INBOX",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AllChatsScreen(snapshot)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.grey[300],
                      textColor: Colors.black,
                      child: Text("SIGN OUT",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => Login(),),
                                (Route<dynamic> route) => false);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
