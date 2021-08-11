import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Post extends StatefulWidget {

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
        // showDialog(
        //   context: context,
        //   builder: (_) => new AlertDialog(
        //     title: new Text("Draft"),
        //     content: new Text("Save this post to drafts"),
        //     actions: <Widget>[
        //       FlatButton(
        //         child: Text('Yes'),
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //           return true;
        //         },
        //       ),
        //       FlatButton(
        //         child: Text('No'),
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //           return true;
        //         },
        //       )
        //     ],
        //   )
        // );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Color.fromRGBO(75, 0, 130, 1)
          ),
          leading: IconButton(
            icon: Icon(CupertinoIcons.xmark, color: Color.fromRGBO(75, 0, 130, 1)),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
  
      ),
    );
  }
}