import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StreamUsers extends StatefulWidget {
  
  @override
  _StreamUsersState createState() => _StreamUsersState();
  StreamUsers({this.title, this.uid, this.users, this.streamUsers});

  final String title;
  final String uid;
  final List users;
  final bool streamUsers;
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
      body: !widget.streamUsers ? 
        (widget.users.length == 0 ? 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Nobody")
              ],
            )
          ) : ListView.builder(
            itemCount: widget.users.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(75, 0, 130, 1),
                      radius: 40.0,
                    ),
                    title: Text(widget.users[index]),
                  ),
                  SizedBox(height: 5.0),
                  Divider()
                ],
              );
            },
          )
        ) : Container(
        child: StreamBuilder<DocumentSnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.data[widget.title].length == 0){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Nobody")
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data[widget.title].length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(75, 0, 130, 1),
                        radius: 40.0,
                      ),
                      title: Text(snapshot.data[widget.title][index]),
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