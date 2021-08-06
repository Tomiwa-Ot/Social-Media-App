import 'package:flutter/material.dart';

class ExpandPost extends StatefulWidget {

  @override
  _ExpandPostState createState() => _ExpandPostState();
}

class _ExpandPostState extends State<ExpandPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(75, 0, 130, 1),
        ),
      ),
    );
  }
}