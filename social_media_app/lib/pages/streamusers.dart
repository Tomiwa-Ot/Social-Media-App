import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StreamUsers extends StatefulWidget {
  
  @override
  _StreamUsersState createState() => _StreamUsersState();
  StreamUsers({this.title, this.uid,});

  final String title;
  final String uid;
}


class _StreamUsersState extends State<StreamUsers> {

  User user = FirebaseAuth.instance.currentUser;
  Stream<DocumentSnapshot> stream;

  void initState(){
    if(user != null){
      stream = FirebaseFirestore.instance.collection("users")
        .doc(widget.uid).snapshots();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.title,
          style: TextStyle(
            color: Color.fromRGBO(75, 0, 130, 1),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(75, 0, 130, 1),
        ),
        backgroundColor: Colors.white
      ),
      body:  Container(
        child: StreamBuilder<DocumentSnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(jsonDecode(snapshot.data[widget.title]).length == 0){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Nobody",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(100, 100, 100, 1)
                      ),
                    )
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: jsonDecode(snapshot.data[widget.title]).length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(75, 0, 130, 1),
                        radius: 40.0,
                      ),
                      title: Text(jsonDecode(snapshot.data[widget.title])[index]),
                    ),
                    SizedBox(height: 5.0),
                    Divider()
                  ],
                );
              },
            );
          },
        ),
      )
    );
  }
}