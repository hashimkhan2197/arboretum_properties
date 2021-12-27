import 'package:arboretumproperties/ChatScreens/chat_screen.dart';
import 'package:arboretumproperties/admin_panel/inbox/inbox.dart';
import 'package:arboretumproperties/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:intl/intl.dart';

class ApartmentDetails extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  final DocumentSnapshot apartmentSnap;
  final streamType ;

  ApartmentDetails(this.userSnapshot,this.apartmentSnap,this.streamType);

  @override
  _ApartmentDetailsState createState() => _ApartmentDetailsState();
}

class _ApartmentDetailsState extends State<ApartmentDetails> {

  final f = new DateFormat('dd-MM-yyyy hh:mm');

  bool _multiPickerBool = false;
  List<DateTime> _multiDateList = List<DateTime>();

  @override
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
    for(Timestamp date in widget.apartmentSnap.data['bookedOn']){
      _multiDateList.add(date.toDate());
    }
    for(String url in widget.apartmentSnap.data['urlList']){
      urlPicList.add(Image.network(
        url,
        fit: BoxFit.cover,
      ));
    }
    if(widget.apartmentSnap.data['views']==null){
      Firestore.instance.collection('properties').document(widget.apartmentSnap.documentID).updateData({
        'views': 1
      });
      print('1');
    } else{
      Firestore.instance.collection('properties').document(widget.apartmentSnap.documentID).updateData({
        'views': widget.apartmentSnap.data['views'] + 1
      });
    print((widget.apartmentSnap.data['views'] + 1).toString());
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
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
            SizedBox(height: 10),
            Container(
              height: height *.4,
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
            Row(
              children: [
                Text('Type of property'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  widget.apartmentSnap['typeOfProperty'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(widget.streamType != 'shortTermStay'?'Size of property':'Sleeps'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  widget.apartmentSnap['sizeOfProperty'],
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
                Text(
                  widget.apartmentSnap['typeOfRoom'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Cost'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  '£' +
                      widget.apartmentSnap['costOfRent'].toString() +
                      " " +
                      widget.apartmentSnap['rentTimeInterval'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Address'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Expanded(
                  child: Text(
                    widget.apartmentSnap['address'],
                    maxLines: 8,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            if(widget.streamType != 'shortTermStay')
            Row(
              children: [
                Text('Avalable from'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  f.format(widget.apartmentSnap['availableFrom'].toDate()).toString().split(' ').first,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey),
                ),
              ],
            ),

            if(widget.streamType == 'shortTermStay')
            SizedBox(height: 15),
            if(widget.streamType == 'shortTermStay')
            Center(
                child: Text(
                  'Booked On',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
            if(widget.streamType == 'shortTermStay')
            SizedBox(height: 8),

            if(_multiPickerBool == true)
              SfDateRangePicker(
                onSelectionChanged:null,
                selectionMode: DateRangePickerSelectionMode.multiple,
                initialSelectedDates: _multiDateList,
              ),
            if(widget.streamType == 'shortTermStay')
            Padding(
              padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.black,
                color: Colors.grey[200],
                label: Text(_multiPickerBool == true?'Done':'View Dates'),
                icon: Icon(_multiPickerBool == true?Icons.check_circle:Icons.date_range),
                onPressed: () {
                  setState(() {
                    _multiPickerBool = !_multiPickerBool;
                  });

                },
              ),
            ),
            if(widget.streamType == 'shortTermStay')
            SizedBox(height: 25),
            Text(
              widget.apartmentSnap['description'],
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Extra cost'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  '£' + widget.apartmentSnap['securityDeposit'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Center(
                child: Text(
              'Amenities',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(height: 10),
//            Text(
//              'Shared living room',
//              style: TextStyle(fontSize: 15),
//            ),
//            SizedBox(height: 5),
            Text(
              widget.apartmentSnap.data['furnishings'],
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 5),
            if(widget.apartmentSnap.data['garden']==true)
            Text(
              'Garden / roof terrace',
              style: TextStyle(fontSize: 15),
            ),
            if(widget.apartmentSnap.data['garden']==true)
            SizedBox(height: 5),
            if(widget.apartmentSnap.data['balcony']==true)
            Text(
              'Balcony',
              style: TextStyle(fontSize: 15),
            ),
            if(widget.apartmentSnap.data['balcony']==true)
            SizedBox(height: 5),
            if(widget.apartmentSnap.data['parking']==true)
              Text(
                'Parking',
                style: TextStyle(fontSize: 15),
              ),
            if(widget.apartmentSnap.data['parking']==true)
              SizedBox(height: 5),
            if(widget.apartmentSnap.data['livingRoom']==true)
              Text(
                'Living Room',
                style: TextStyle(fontSize: 15),
              ),
            if(widget.apartmentSnap.data['livingRoom']==true)
              SizedBox(height: 5),
            if(widget.apartmentSnap.data['garage']==true)
              Text(
                'Garage',
                style: TextStyle(fontSize: 15),
              ),
            if(widget.apartmentSnap.data['garage']==true)
              SizedBox(height: 5),
            if(widget.apartmentSnap.data['disableAccess']==true)
              Text(
                'Disabled Access',
                style: TextStyle(fontSize: 15),
              ),
            if(widget.apartmentSnap.data['disableAccess']==true)
              SizedBox(height: 5),
            Row(
              children: [
                Text('Bills included'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  widget.apartmentSnap.data['billsIncluded'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Broadband'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  widget.apartmentSnap.data['broadband'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              'Existing Housemates',
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
                  widget.apartmentSnap['existingGender'],
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
                  widget.apartmentSnap['existingSmoking'],
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
                  widget.apartmentSnap['existingPets'],
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
                  widget.apartmentSnap['existingOccupation'],
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
                  widget.apartmentSnap['existingMinAge'] +
                      ' to ' +
                      widget.apartmentSnap['existingMaxAge'],
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              'New Housemate Preferences',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(height: 10),
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
                Text('pets'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['newPets'],
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
                Text('Couple welcome'),
                SizedBox(width: 5),
                Text(
                  ' | ',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(width: 5),
                Text(
                  widget.apartmentSnap['newCouplesWelcome'],
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
            SizedBox(height: 15),
            Center(
              child: RaisedButton.icon(
                color: Colors.black,
                padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                onPressed: () {
                  _customLaunch('tel: ' + widget.apartmentSnap['phoneNumber']);
                },
                label: Text(
                  'call',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initiateChatConversation(
              ctx: context,
              receiverName: widget.apartmentSnap.data['personName'],
              receiverId: widget.apartmentSnap.data['personUid'],
              receiverEmail: widget.apartmentSnap.data['personEmail'],
              receiverPicture: widget.apartmentSnap.data['personPic']
          );

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
        receiverId,receiverPicture}) async {

    if(widget.userSnapshot.data['email']!= receiverEmail){

      List<String> userNames = [widget.userSnapshot.data['name'], receiverName];
      List<String> userEmails = [widget.userSnapshot.data['email'], receiverEmail];
      List<String> userUids = [widget.userSnapshot.data.documentID, receiverId];
      List<String> userPics = [widget.userSnapshot.data['userImage'], receiverPicture];

      String chatRoomId =
      ChatService.getChatRoomId(widget.userSnapshot.data.documentID, receiverId);

      Map<String, dynamic> chatRoom = {
        "usernames": userNames,
        'useremails': userEmails,
        'useruids': userUids,
        'userPics':userPics,
        "chatRoomId": chatRoomId,
      };

      await ChatService.addChatRoom(chatRoom, chatRoomId);

      Navigator.push(
          ctx,
          MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(widget.userSnapshot,chatRoomId, receiverName, receiverId,receiverPicture)));

    }else{
      showDialog(
          context: context,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.red[400],
                )),
            title: Text("Chat"),
            content:
            Text("This Ad was posted by you. You cannot chat with yourself."),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.red[400]),
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
