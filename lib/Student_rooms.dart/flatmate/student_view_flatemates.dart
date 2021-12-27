import 'package:arboretumproperties/Student_rooms.dart/flatmate/flatmate_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentViewFlatmates extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  StudentViewFlatmates(this.userSnapshot);

  @override
  _StudentViewFlatmatesState createState() => _StudentViewFlatmatesState();
}

class _StudentViewFlatmatesState extends State<StudentViewFlatmates> {

  int sortTypeSelector = 1;
  String sortTypeString;
  bool streamBool;

  Stream _stream;
  @override
  void initState() {
    sortTypeString = 'timePosted';
    streamBool = true;
    _stream = Firestore.instance
        .collection('studentAds')
        .where('approve',isEqualTo:'Approved')
        .orderBy(sortTypeString,descending: streamBool)
        .snapshots();

    super.initState();
  }

  void _roomSortBottomsheet(context) {
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
                              .collection('studentAds').where('approve',isEqualTo:'Approved')
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
                              .collection('studentAds').where('approve',isEqualTo:'Approved')
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
                          sortTypeString = 'budget';
                          streamBool= false;
                          _stream = Firestore.instance
                              .collection('studentAds').where('approve',isEqualTo:'Approved')
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
                          sortTypeString = 'budget';
                          streamBool = true;
                          _stream = Firestore.instance
                              .collection('studentAds').where('approve',isEqualTo:'Approved')
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
          'View Flatmates',
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
                    _roomSortBottomsheet(context);
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
                                    builder: (context) => FlatmateDetails(widget.userSnapshot,snapshot.data.documents[index])));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data.documents[index]
                                                .data['title'],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex:1,
                                                child: Text(
                                                  (snapshot.data.documents[index]
                                                .data['lastNameDisplay']==true?snapshot.data.documents[index]
                                                      .data['firstName']+" "+snapshot.data.documents[index]
                                                .data['lastName']:snapshot.data.documents[index]
                                                      .data['firstName'])+" ,",
                                                  style: TextStyle(
                                                      fontSize: 16, color: Colors.grey),
                                                ),
                                              ),

//                                              SizedBox(width: 10),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  snapshot.data.documents[index]
                                                      .data['gender'],
                                                  style: TextStyle(
                                                      fontSize: 16, color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            snapshot.data.documents[index]
                                                .data['personAge']+' years old',
                                            style:
                                            TextStyle(fontSize: 16, color: Colors.grey),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            snapshot.data.documents[index]
                                                .data['typeOfRoom'],
                                            style:
                                            TextStyle(fontSize: 16, color: Colors.grey),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                'Budget',
                                                style: TextStyle(
                                                    fontSize: 16, color: Colors.grey),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                '|',
                                                style: TextStyle(
                                                    fontSize: 16, color: Colors.grey),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                snapshot.data.documents[index]
                                                    .data['budget'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12,),
                                          if (snapshot.data.documents[index].data['personUid']==widget.userSnapshot.data.documentID)
                                          GestureDetector(
                                            onTap: (){
                                              showDialog(
                                                  context: context,
                                                  child: AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        new BorderRadius.circular(
                                                            18.0),
                                                        side: BorderSide(
                                                          color: Colors.red[400],
                                                        )),
                                                    title: Text("Delete Post"),
                                                    content: Text(
                                                        "Are you sure you want to delete this post?"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              color: Colors.red[400]),
                                                        ),
                                                        onPressed: () {
                                                          Firestore.instance.collection('studentAds')
                                                              .document(snapshot.data.documents[index]
                                                              .documentID).delete();
                                                          Navigator.pop(context);
                                                        },
                                                      ),

                                                      FlatButton(
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color: Colors.red[400]),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                      )
                                                    ],
                                                  ));

                                            },
                                            child: Text(
                                              'Delete',
                                              style:
                                              TextStyle(fontSize: 16, color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .data
                                              .documents[index]
                                              .data['urlList'][0]),
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );

              }
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}
