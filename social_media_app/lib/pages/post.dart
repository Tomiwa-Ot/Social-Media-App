import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';


class Post extends StatefulWidget {
  Post({Key key, this.file});


  @override
  _PostState createState() => _PostState();

  final File file;
}

class _PostState extends State<Post> {

  TextEditingController commentController = new TextEditingController();
  final commentKey = GlobalKey<FormState>();
  User user = FirebaseAuth.instance.currentUser;
  bool uploading = false;

  String commentValidator(String value){
    if (value.isEmpty)
      return '*This field cannot be empty';
    else
      return null;
  }
  
  upload() async {
    if(user != null){
      setState(() {
        uploading = true;
      });
      String fileExt = p.extension(widget.file.path);
      String fileName = p.basenameWithoutExtension(widget.file.path);
      String curTime = DateTime.now().toIso8601String().toString();
      final _firebaseStorage = FirebaseStorage.instance;
      var snapshot = await _firebaseStorage.ref()
        .child('posts/${user.uid}/$fileName$curTime.$fileExt')
        .putFile(widget.file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("users").doc(user.uid).collection("posts")
        .doc().set({
          "user" : user.uid,
          "photoLink" : downloadUrl,
          "comment" : commentController.text,
          "likes" : jsonEncode([]).toString(),
          "timestamp" : DateTime.now().toIso8601String(),
        }).then((value) {
          var doc = FirebaseFirestore.instance.collection("users").doc(user.uid).snapshots();
          // doc.
          // int val = doc.toList()
          // FirebaseFirestore.instance.collection("users").doc(user.uid).update({
          //   "NoPosts" : val++
          // });
          setState(() {
            uploading = false;
          });
          Navigator.of(context).pop();
        });
    }
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
              onPressed: uploading ? null : (){
                if(commentKey.currentState.validate()){
                  upload();
                }
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
                uploading ? LinearProgressIndicator() : Container(),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300.0,
                    child: Image.file(
                      File(widget.file.path)
                    ),
                  )
                ),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  key: commentKey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: TextFormField(
                      validator: commentValidator,
                      controller: commentController,
                      maxLines: 4,
                      enabled: !uploading,
                      showCursor: !uploading,
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
                        hintText: "Comment",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}