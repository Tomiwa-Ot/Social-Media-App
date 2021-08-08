import 'package:flutter/material.dart';

class StreamUsers extends StatefulWidget {
  
  @override
  _StreamUsersState createState() => _StreamUsersState();
  StreamUsers({this.title, this.uid});

  final String title;
  final String uid;
}

// Scan 

class _StreamUsersState extends State<StreamUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
    );
  }
}