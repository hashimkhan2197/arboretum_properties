import 'package:arboretumproperties/apartments/apartments_list/apartments_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApartmentList extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  final String pageTitle;
  final streamType ;

  ApartmentList(this.userSnapshot,this.pageTitle,this.streamType);

  @override
  _ApartmentListState createState() => _ApartmentListState();
}

class _ApartmentListState extends State<ApartmentList> {

  final f = new DateFormat('dd-MM-yyyy hh:mm');

  int sortTypeSelector = 1;
  String sortTypeString;
  bool streamBool;

  Stream _stream;
  @override
  void initState() {
    sortTypeString = 'timePosted';
    streamBool = true;
    _stream = Firestore.instance
        .collection('properties')
        .where(widget.streamType, isEqualTo: true)
        .orderBy(sortTypeString,descending: streamBool)
        .snapshots();

    super.initState();
  }

  void _sortBottomsheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              height: 230,
              //height: MediaQuery.of(context).size.height * 80,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sortTypeSelector = 1;
                          sortTypeString = 'timePosted';
                          _stream = Firestore.instance
                              .collection('properties')
                              .where(widget.streamType, isEqualTo: true)
                              .orderBy(sortTypeString,descending: streamBool)
                              .snapshots();
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: sortTypeSelector,
                            onChanged: null,
                            activeColor: Colors.blue,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Newest ads',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sortTypeSelector = 2;
                          sortTypeString = 'timePosted';
                          _stream = Firestore.instance
                              .collection('properties')
                              .where(widget.streamType, isEqualTo: true)
                              .orderBy(sortTypeString,descending: streamBool)
                              .snapshots();
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: sortTypeSelector,
                            onChanged: null,
                            activeColor: Colors.blue,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Last update',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sortTypeSelector = 3;
                          sortTypeString = 'costOfRent';
                          streamBool= false;
                          _stream = Firestore.instance
                              .collection('properties')
                              .where(widget.streamType, isEqualTo: true)
                              .orderBy(sortTypeString,descending: streamBool)
                              .snapshots();
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: sortTypeSelector,
                            onChanged: null,
                            activeColor: Colors.blue,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Price Low',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sortTypeSelector = 4;
                          sortTypeString = 'costOfRent';
                          streamBool = true;
                          _stream = Firestore.instance
                              .collection('properties')
                              .where(widget.streamType, isEqualTo: true)
                              .orderBy(sortTypeString,descending: streamBool)
                              .snapshots();
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            value: 4,
                            groupValue: sortTypeSelector,
                            onChanged: null,
                            activeColor: Colors.blue,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Price High',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          widget.pageTitle,
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
          shrinkWrap: true,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[600]),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Sort',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _sortBottomsheet(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: MediaQuery.of(context).size.height*.68,
                      child: Center(
//                    child: CircularProgressIndicator(),
                          ),
                    );
                  }
                  return Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height*.68,
                    child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApartmentDetails(widget.userSnapshot,
                                          snapshot.data.documents[index],widget.streamType)));
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }),
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }

}
