import 'package:arboretumproperties/Student_rooms.dart/flatmate/flatmate_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  RequestList(this.userSnapshot);

  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          'Requests',
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
        padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('studentAds')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
//                    child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => ApproveRequests()));

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FlatmateDetails(widget.userSnapshot,snapshot.data.documents[index])));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        height: 225,
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
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex:1,
                                            child: Text(
                                              ( snapshot.data.documents[index]
                                                  .data['lastNameDisplay']==true?snapshot.data.documents[index]
                                                  .data['firstName']+" "+snapshot.data.documents[index]
                                                  .data['lastName']:snapshot.data.documents[index]
                                                  .data['firstName'])+" ,",
                                              style: TextStyle(
                                                  fontSize: 16, color: Colors.grey),
                                            ),
                                          ),

//                                          SizedBox(width: 10),
                                          Expanded(flex:1,
                                            child: Text(
                                              snapshot.data.documents[index]
                                                  .data['gender'],
                                              style: TextStyle(
                                                  fontSize: 16, color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        snapshot.data.documents[index]
                                            .data['personAge']+' years old',
                                        style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        snapshot.data.documents[index]
                                            .data['typeOfRoom'],
                                        style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            'Budget',
                                            style: TextStyle(
                                                fontSize: 16, color: Colors.grey),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            '|',
                                            style: TextStyle(
                                                fontSize: 16, color: Colors.grey),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            snapshot.data.documents[index]
                                                .data['budget'],
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Status',
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
                                                .data['approve']==null?
                                            'pending':snapshot.data.documents[index]
                                                .data['approve'],
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
//                                      if (snapshot.data.documents[index].data['personUid']==widget.userSnapshot.data.documentID)
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
                  });

            }
        ),
      ),
    );
  }

}
