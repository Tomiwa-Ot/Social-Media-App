import 'package:flutter/material.dart';

class Drafts extends StatefulWidget {

  @override
  _DraftsState createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(75, 0, 130, 1),
        ),
        title: Text("Drafts",
          style: TextStyle(
            color: Color.fromRGBO(75, 0, 130, 1),
          ),
        ),
      ),
    );
  }
}