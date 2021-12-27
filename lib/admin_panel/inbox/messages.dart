import 'package:arboretumproperties/admin_panel/inbox/inbox.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  Messages({Key key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Messages',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/man2.png'),
                radius: 25,
              ),
              title: Text('Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15)),
              
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3),
                  Text(
                    'Hey I\'m interested in this room...',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 3),
                  Text(
                    '1 MINUTE AGO',
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Inbox()));
              },
            ),
            Divider(),
            
          ],
        ),
      ),
    );
  }
}