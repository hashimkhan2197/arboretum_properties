
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class StatsList extends StatefulWidget {
  @override
  _StatsListState createState() => _StatsListState();
}

class _StatsListState extends State<StatsList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          'Stats',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
//        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
//      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: StreamBuilder(
            stream: Firestore.instance.collection('users').where('x',isEqualTo: 'good').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
//                    child: CircularProgressIndicator(),
                      ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
//                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                         Text('Total number of users : ', style: TextStyle(fontSize: 18,color: Colors.grey),),
                          Text(snapshot.data.documents.length.toString(), style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("User List", style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,),
                    ),


                    ///List of users
                    for (DocumentSnapshot p in snapshot.data.documents)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) =>AdminEditAdvert(widget.userSnapshot,
//                              p)));
                            },
                            child: ListTile(
                              trailing: IconButton(icon: Icon(Icons.delete_forever,color: Colors.red,),
                              onPressed:  (){
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
                                      title: Text("Delete User"),
                                      content: Text(
                                          "Are you sure you want to delete this user?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                                color: Colors.red[400]),
                                          ),
                                          onPressed: () {
                                            Firestore.instance.collection('users')
                                                .document(p.documentID).
                                            updateData({
                                              'x':'bad'
                                            });
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
                              ),
                              leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      NetworkImage(p.data['userImage'])),
                              title: Text(p.data['name']),
                              subtitle: Text(p.data['email']),
                            ),
                          ),
//                          Divider()
                        ],
                      ),


                  ],
                ),
              );
            }),
      ),
    );
  }
}
