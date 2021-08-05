import 'package:flutter/material.dart';
import 'package:social_media_app/pages/post.dart';

class Feed extends StatefulWidget {

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(75, 0, 130, 1),
        child: Icon(Icons.add, color: Color.fromRGBO(255,40,147, 1)),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Post()
          ));
        },
      ),
    );
  }
}