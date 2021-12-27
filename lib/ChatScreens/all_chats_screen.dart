import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
class AllChatsScreen extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  AllChatsScreen(this.userSnapshot);
  @override
  _AllChatsScreenState createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
          .where('useremails',arrayContains: widget.userSnapshot.data['email'])
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final snapShotData = snapshot.data.documents;
            if (snapShotData.length == 0) {
              return Center(
                child: Text("No chats yet."),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapShotData[index];
                  String otherSenderName = findOtherSenderName(data);
                  String otherSenderEmail = findOtherSenderEmail(data);
                  String otherSenderUid = findOtherSenderId(data);
                  String otherSenderPic = findOtherPicture(data);
                  return
                    ListTile(
//                      trailing: IconButton(
//                        icon: Icon(Icons.delete_forever,size: 25,color: Colors.grey,),
//                        onPressed: () {
//                          Firestore.instance
//                              .collection('chat')
//                              .document(data.documentID)
//                              .delete()
//                              .catchError((err) {
//                            print(err);
//                          });
//                        },
//                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(otherSenderPic),
                        radius: 30,
                      ),
                      title: Text(otherSenderName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18)),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            otherSenderEmail,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 3),
//                          Text(
//                            '1 MINUTE AGO',
//                            style: TextStyle(fontSize: 11, color: Colors.black),
//                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return ChatScreen(widget.userSnapshot,data.documentID, otherSenderName,otherSenderUid,otherSenderPic);
                            }));
                      },

                    );
                },
                itemCount: snapshot.data.documents.length,
              ),
            );
          },
        ),
      ),
    );
  }

  String findOtherSenderName(DocumentSnapshot data) {
    List<dynamic> userNames = data.data['usernames'];

    userNames.remove(widget.userSnapshot.data['name']);
    return userNames[0];
  }

  String findOtherSenderEmail(DocumentSnapshot data) {
    List<dynamic> userEmails = data.data['useremails'];

    userEmails.remove(widget.userSnapshot.data['email']);
    return userEmails[0];
  }
  String findOtherSenderId(DocumentSnapshot data) {
    List<dynamic> userids = data.data['useruids'];

    userids.remove(widget.userSnapshot.data.documentID);
    return userids[0];
  }
  String findOtherPicture(DocumentSnapshot data) {
    List<dynamic> userPics = data.data['userPics'];

    userPics.remove(widget.userSnapshot.data['userImage']);
    return userPics[0];
  }

}
