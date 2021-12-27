import 'package:arboretumproperties/ChatScreens/chat_screen.dart';
import 'package:arboretumproperties/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:url_launcher/url_launcher.dart';

class FlatmateDetails extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  final DocumentSnapshot apartmentSnap;

  FlatmateDetails(this.userSnapshot, this.apartmentSnap);

  @override
  _FlatmateDetailsState createState() => _FlatmateDetailsState();
}

class _FlatmateDetailsState extends State<FlatmateDetails> {
  final _scacffoldKey = GlobalKey<ScaffoldState>();

  @override
  void _customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  List<dynamic> urlPicList = List<dynamic>();

  @override
  void initState() {
    for (String url in widget.apartmentSnap.data['urlList']) {
      urlPicList.add(Image.network(
        url,
        fit: BoxFit.cover,
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scacffoldKey,
      appBar: AppBar(
        title: Text(
          'Flatmate details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
            SizedBox(height: 15),
            Text(
              widget.apartmentSnap['title'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Container(
              height: height / 3.0,
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Carousel(
                  overlayShadow: false,
                  dotBgColor: Colors.transparent,
                  autoplay: false,
                  dotIncreaseSize: 2,
                  dotSize: 5,
                  // dotSpacing: 30,

                  dotIncreasedColor: Colors.white,
                  dotColor: Colors.black,
                  images: urlPicList,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              widget.apartmentSnap['description'],
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Username: '),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['firstName'] +
                      " " +
                      widget.apartmentSnap['lastName'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(' Age: '),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['personAge'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Budget'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['budget'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Type of room'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['typeOfRoom'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Available from'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  '02 / 01 / 2020',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Period accommodation',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['minPerionStay'] +
                      ' to ' +
                      widget.apartmentSnap['maxPerionStay'] +
                      ' months',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              'Amenities',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(height: 10),
            if (widget.apartmentSnap['sharedLivingRoom'] == true)
              Text(
                'Shared living room',
                style: TextStyle(fontSize: 15),
              ),
            if (widget.apartmentSnap['sharedLivingRoom'] == true)
              SizedBox(height: 5),
            if (widget.apartmentSnap['furnishings'] == true)
              Text(
                'furnished',
                style: TextStyle(fontSize: 15),
              ),
            if (widget.apartmentSnap['furnishings'] == true)
              SizedBox(height: 5),
            if (widget.apartmentSnap['garden'] == true)
              Text(
                'Garden / roof terrace',
                style: TextStyle(fontSize: 15),
              ),
            if (widget.apartmentSnap['garden'] == true) SizedBox(height: 5),
            if (widget.apartmentSnap['balcony'] == true)
              Text(
                'Balcony',
                style: TextStyle(fontSize: 15),
              ),
            if (widget.apartmentSnap['balcony'] == true) SizedBox(height: 5),
            if (widget.apartmentSnap['washingMachine'] == true)
              Text(
                'Washing machine',
                style: TextStyle(fontSize: 15),
              ),
            if (widget.apartmentSnap['washingMachine'] == true)
              SizedBox(height: 5),
            if (widget.apartmentSnap['parking'] == true)
              Text(
                'Parking',
                style: TextStyle(fontSize: 15),
              ),
            if (widget.apartmentSnap['broadBand'] == true) SizedBox(height: 5),
            if (widget.apartmentSnap['broadBand'] == true)
              Text(
                'BroadBand',
                style: TextStyle(fontSize: 15),
              ),
            if (widget.apartmentSnap['disabledAccess'] == true)
              SizedBox(height: 5),
            if (widget.apartmentSnap['disabledAccess'] == true)
              Text(
                'Disabled Access',
                style: TextStyle(fontSize: 15),
              ),
            if (widget.apartmentSnap['ensuite'] == true) SizedBox(height: 5),
            if (widget.apartmentSnap['ensuite'] == true)
              Text(
                'En suite',
                style: TextStyle(fontSize: 15),
              ),
            SizedBox(height: 10),
            Center(
                child: Text(
              'About Me',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Gender'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['gender'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Smoking'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['smoking'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('pets'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['pets'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              'My Preferred Flatmate',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Gender'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['newGender'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Smoking'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['newSmoking'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Occupation'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['newOccupation'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Age range'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['newMinAge'] +
                      ' to ' +
                      widget.apartmentSnap['newMaxAge'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
//            SizedBox(height: 20),
//            if (widget.userSnapshot.data['admin'] != null &&
//                widget.userSnapshot.data['admin'] == true)
//              Center(
//                child: RaisedButton(
//                  color: Colors.black,
//                  padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
//                  onPressed: () async {
//                    await Firestore.instance
//                        .collection('studentAds')
//                        .document(widget.apartmentSnap.documentID)
//                        .updateData({'approve': 'Approved'}).then((value) {
//                      _scacffoldKey.currentState.showSnackBar(SnackBar(
//                        content: Text('Request Approved!',
//                            style: TextStyle(color: Colors.white)),
//                        backgroundColor: Colors.green,
//                      ));
//                    }).catchError((e) {
//                      _scacffoldKey.currentState.showSnackBar(SnackBar(
//                        content: Text('Update Error!',
//                            style: TextStyle(color: Colors.white)),
//                        backgroundColor: Colors.red,
//                      ));
//                    });
//                  },
//                  child: Text(
//                    'Approve',
//                    style: TextStyle(
//                      fontSize: 18,
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//              ),
            SizedBox(height: 20),
            ///Reject ad
            if (widget.userSnapshot.data['admin'] != null &&
                widget.userSnapshot.data['admin'] == true)
              Center(
                child: RaisedButton(
                  color: Colors.black,
                  padding: EdgeInsets.fromLTRB(70, 5, 70, 5),
                  onPressed: () async {
                    await Firestore.instance
                        .collection('studentAds')
                        .document(widget.apartmentSnap.documentID)
                        .updateData({'approve': 'Rejected'}).then((value) {
                      _scacffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('Request Rejected!',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.black87,
                      ));
                    }).catchError((e) {
                      _scacffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('Update Error!',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.red,
                      ));
                    });
                  },
                  child: Text(
                    'Reject',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton:
      widget.userSnapshot.data['admin'] != null &&
              widget.userSnapshot.data['admin'] == true
          ? FloatingActionButton(
              onPressed: () async {
                await Firestore.instance
                    .collection('studentAds')
                    .document(widget.apartmentSnap.documentID)
                    .updateData({'approve': 'Approved'}).then((value) {
                  _scacffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Request Approved!',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                  ));
                }).catchError((e) {
                  _scacffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Update Error!',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.red,
                  ));
                });
              },
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
            )
          :
      FloatingActionButton(
              onPressed: () {
                initiateChatConversation(
                    ctx: context,
                    receiverName: widget.apartmentSnap.data['personName'],
                    receiverId: widget.apartmentSnap.data['personUid'],
                    receiverEmail: widget.apartmentSnap.data['personEmail'],
                    receiverPicture: widget.apartmentSnap.data['personPic']);

//          Navigator.push(
//              context, MaterialPageRoute(builder: (context) => Inbox()));
              },
              child: Icon(
                Icons.mail,
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
            ),
    );
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  void initiateChatConversation(
      {BuildContext ctx,
      String receiverName,
      receiverEmail,
      receiverId,
      receiverPicture}) async {
    if (widget.userSnapshot.data['email'] != receiverEmail) {
      List<String> userNames = [widget.userSnapshot.data['name'], receiverName];
      List<String> userEmails = [
        widget.userSnapshot.data['email'],
        receiverEmail
      ];
      List<String> userUids = [widget.userSnapshot.data.documentID, receiverId];
      List<String> userPics = [
        widget.userSnapshot.data['userImage'],
        receiverPicture
      ];

      String chatRoomId = ChatService.getChatRoomId(
          widget.userSnapshot.data.documentID, receiverId);

      Map<String, dynamic> chatRoom = {
        "usernames": userNames,
        'useremails': userEmails,
        'useruids': userUids,
        'userPics': userPics,
        "chatRoomId": chatRoomId,
      };

      await ChatService.addChatRoom(chatRoom, chatRoomId);

      Navigator.push(
          ctx,
          MaterialPageRoute(
              builder: (context) => ChatScreen(widget.userSnapshot, chatRoomId,
                  receiverName, receiverId, receiverPicture)));
    } else {
      showDialog(
          context: context,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.red[400],
                )),
            title: Text("Chat"),
            content: Text(
                "This Ad was posted by you. You cannot chat with yourself."),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red[400]),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ));
    }
  }
}
