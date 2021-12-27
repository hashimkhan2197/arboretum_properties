import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApartmentOffers extends StatefulWidget {
  ApartmentOffers({Key key}) : super(key: key);

  @override
  _ApartmenttOffersState createState() => _ApartmenttOffersState();
}

class _ApartmenttOffersState extends State<ApartmentOffers> {
  void _customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Offers',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: StreamBuilder(
          stream: Firestore.instance.collection('offers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            ///widget for each offer
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * .5,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                child: Image(
                                  image: NetworkImage(snapshot
                                      .data.documents[index].data['imageUrl']),
                                  fit: BoxFit.fill,
                                ),
                              )),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot
                                  .data.documents[index].data['description'],
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 8),
//                          Padding(
//                            padding: const EdgeInsets.symmetric(
//                                horizontal: 10, vertical: 4),
//                            child: Text(
//                              'Contact: ' +
//                                  snapshot.data.documents[index]
//                                      .data['phoneNumber'],
//                              style: TextStyle(
//                                  color: Colors.black87,
//                                  fontSize: 18,
//                                  fontWeight: FontWeight.w500),
//                            ),
//                          ),
//                          SizedBox(height: 10),
                          Center(
                            child: RaisedButton.icon(
                              color: Colors.black,
                              padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                              icon: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _customLaunch('tel: '+snapshot.data.documents[index].data['phoneNumber']);
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
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                )
                );
          }),
    );
  }
}
