import 'package:arboretumproperties/ChatScreens/all_chats_screen.dart';
import 'package:arboretumproperties/admin_panel/admin_advert_list.dart';
import 'package:arboretumproperties/admin_panel/admin_postadvert.dart';
import 'package:arboretumproperties/admin_panel/approve_request/request_list.dart';
import 'package:arboretumproperties/admin_panel/offers.dart';
import 'package:arboretumproperties/admin_panel/post_offer.dart';
import 'package:arboretumproperties/admin_panel/stats.dart';
import 'package:arboretumproperties/login_signup/login.dart';
import 'package:flutter/material.dart';

class AdminPanelMainPage extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  AdminPanelMainPage(this.userSnapshot);

  @override
  _AdminPanelMainPageState createState() => _AdminPanelMainPageState();
}

class _AdminPanelMainPageState extends State<AdminPanelMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin panel',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              child: Image(
                image: AssetImage('assets/logo.png'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.grey[300],
                textColor: Colors.black,
                child: Text("POST ADVERTS",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminPostAdvert(widget.userSnapshot)));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.grey[300],
                textColor: Colors.black,
                child: Text("FLATMATE ADVERTS",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RequestList(widget.userSnapshot)));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
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
                      MaterialPageRoute(builder: (context) => AllChatsScreen(widget.userSnapshot)));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.grey[300],
                textColor: Colors.black,
                child: Text("POST OFFER",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostOffer()));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.grey[300],
                textColor: Colors.black,
                child: Text("ADVERTS",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminAdvertList(widget.userSnapshot)));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.grey[300],
                textColor: Colors.black,
                child: Text("OFFERS",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminOffers()));
                },
              ),
            ),

            ///Stats
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.grey[300],
                textColor: Colors.black,
                child: Text("STATS",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StatsList()));
                },
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.black,
                textColor: Colors.black,
                child: Text("SIGN OUT",
                    style: TextStyle(
                      fontSize: 16.0,color: Colors.white
                    )),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => Login(),),
                          (Route<dynamic> route) => false);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
