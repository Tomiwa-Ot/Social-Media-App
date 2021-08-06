import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';


class Post extends StatefulWidget {

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  ZefyrController _controller;
  FocusNode _focusNode;

  void initState(){
    _focusNode = FocusNode();
    final document = _loadDocument();
    _controller = ZefyrController(document);
    super.initState();
  }

    NotusDocument _loadDocument(){
    final Delta delta = Delta()..insert("Type something ...\n");
    return NotusDocument.fromDelta(delta);
  }

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
        body: ZefyrScaffold(
          child: ZefyrEditor(
            padding: EdgeInsets.all(16.0),
            controller: _controller,
            focusNode: _focusNode,
          ),
        )
      ),
    );
  }
}