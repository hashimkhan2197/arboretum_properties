
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  final AsyncSnapshot userSnapshot;
  final String chatRoomId;
  Messages(this.userSnapshot,this.chatRoomId);
  @override
  Widget build(BuildContext context) {
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat').document(chatRoomId).collection('messages')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(

                  chatDocs[index]['text'],
                  chatDocs[index]['username'],
                  chatDocs[index]['userId'] == userSnapshot.data.documentID,
                  chatDocs[index]['createdAt'],
                  key: ValueKey(chatDocs[index].documentID),
                ),
              );
            });
      }
  }
