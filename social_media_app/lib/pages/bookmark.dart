import 'package:flutter/material.dart';

class Bookmark extends StatefulWidget {

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
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
        title: Text("Bookmark",
          style: TextStyle(
            color: Color.fromRGBO(75, 0, 130, 1),
          ),
        ),
      ),
    );
  }
}