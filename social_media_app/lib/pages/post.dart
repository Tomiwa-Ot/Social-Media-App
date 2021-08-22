import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Post extends StatefulWidget {
  Post({Key key, this.file});


  @override
  _PostState createState() => _PostState();

  final File file;
}

class _PostState extends State<Post> {

  
  upload(){
    
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
          actions: [
            IconButton(
              icon: Icon(Icons.send),
              onPressed: (){
                upload();
              },
            )
          ],
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FileImage(widget.file)
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: TextFormField(
                    // validator: fieldvalidator,
                    // controller: tecDescription,
                    maxLines: 4,
                    // onChanged: (_dec) => orderDescription = _dec,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Color.fromRGBO(237,47,89, 1),
                    decoration: new InputDecoration(
                      fillColor: Color.fromRGBO(234, 234, 234, 1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(234, 234, 234, 1),
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(234, 234, 234, 1),
                        )
                      ),
                      filled: true,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(0.0),
                      ),
                      hintText: "Description",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      )
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}