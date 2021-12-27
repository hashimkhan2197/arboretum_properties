import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userName, this.isMe,this.timestamp, {this.key});

  final Timestamp timestamp;
  final Key key;
  final String message;
  final String userName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                  //color: Colors.red,
                  gradient: isMe
                      ? LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1,
                        1
                      ],
                      colors: [
                        Colors.black,
                        Colors.black,
                      ])
                      : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1,
                        1
                      ],
                      colors: [
                        Colors.white,
                        Colors.white,
                      ]),
                  borderRadius: isMe
                      ? BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(5),
                  )
                      : BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      message,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 6,),
                    Text(
                      '${timestamp.toDate().toString().split(' ').first}',
                      style: TextStyle(
                        color: isMe ?Colors.white70: Colors.black87,fontSize: 13
                      ),
                      textAlign: TextAlign.end ,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
