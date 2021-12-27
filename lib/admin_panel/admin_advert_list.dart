import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'admin_edit_adverts.dart';

class AdminAdvertList extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  AdminAdvertList(this.userSnapshot);
  @override
  _AdminAdvertListState createState() => _AdminAdvertListState();
}

class _AdminAdvertListState extends State<AdminAdvertList> {

  final f = new DateFormat('dd-MM-yyyy hh:mm');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          'Adverts',
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
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('properties')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
//                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>AdminEditAdvert(widget.userSnapshot,
                                          snapshot.data.documents[index])));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
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
                          children: [
                            Container(
                                height:220,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                  child: Image(
                                    image: NetworkImage(snapshot
                                        .data
                                        .documents[index]
                                        .data['urlList'][0]),fit: BoxFit.cover,),
                                )),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.documents[index]
                                        .data['title'],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    snapshot.data.documents[index]
                                        .data['address'],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data.documents[index]
                                            .data['typeOfRoom'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(width: 10),
                                      if(snapshot.data.documents[index]
                                          .data['shortTermStay']==false)
                                      Text(
                                        '|',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      if(snapshot.data.documents[index]
                                          .data['shortTermStay']==false)
                                      SizedBox(width: 10),
                                      if(snapshot.data.documents[index]
                                          .data['shortTermStay']==false)
                                      Text(
                                        'Available from ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      if(snapshot.data.documents[index]
                                          .data['shortTermStay']==false)
                                      Text(
                                            f.format(snapshot.data.documents[index]
                                                .data['availableFrom'].toDate()).toString().split(' ').first,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Cost',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '|',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '£' +
                                            snapshot.data.documents[index]
                                                .data['costOfRent'].toString() +
                                            " " +
                                            snapshot.data.documents[index]
                                                .data['rentTimeInterval'],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ///views
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Viewed',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '|',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(width: 10),
                                      Text(

                                            snapshot.data.documents[index]
                                                .data['views'].toString()+ ' times',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }

}
