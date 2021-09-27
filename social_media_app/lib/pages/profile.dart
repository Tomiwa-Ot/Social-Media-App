import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/pages/streamusers.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

  Profile({this.uId}); 

  final String uId;
}

class _ProfileState extends State<Profile> {

  String firstname, lastname, email;
  bool followButtonVisible = false, following = false;
  User user = FirebaseAuth.instance.currentUser;
  Stream<DocumentSnapshot> stream;
  Stream<QuerySnapshot> postStream;
  TextEditingController nameController = new TextEditingController();

  ImageSource get cameraSource => ImageSource.camera;
  ImageSource get gallerySource => ImageSource.gallery;

  void initState(){
    if(user != null){
      stream = FirebaseFirestore.instance.collection("users")
        .doc(widget.uId).snapshots();
      postStream = FirebaseFirestore.instance.collection("users")
        .doc(widget.uId).collection("posts").orderBy("timestamp").snapshots();
    }
    showFollowButton();
    super.initState();
  }

  void showFollowButton(){
    if(user.uid == widget.uId){
      setState(() {
        followButtonVisible = false;
      });
    }else{
      setState(() {
        followButtonVisible = true;
      });
    }
  }

  void uploadProfilePhoto(ImageSource source) async {
    bool uploading = false;
   final file = await ImagePicker.pickImage(source: source, imageQuality: 70);
    if(file != null){
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Upload Profile Photo"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                height: 100.0,
                child: Center(
                  child: uploading ? CircularProgressIndicator() : CircleAvatar(
                    radius: 50.0,
                    backgroundImage: FileImage(file),
                  ),
                )
              );
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close',
                style: TextStyle(
                  color: Color.fromRGBO(75, 0, 130, 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Color.fromRGBO(75, 0, 130, 1),
              child: Text('Upload',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: !uploading ? () async{
                if(user != null){
                 try{
                   setState(() {
                     uploading = true;
                   });
                    String fileExt = p.extension(file.path);
                    String fileName = p.basenameWithoutExtension(file.path);
                    String curTime = DateTime.now().toIso8601String().toString();
                    final _firebaseStorage = FirebaseStorage.instance;
                    var snapshot = await _firebaseStorage.ref()
                      .child('users/${user.uid}/ProfilePhoto/$fileName$curTime.$fileExt')
                      .putFile(file);
                    var downloadUrl = await snapshot.ref.getDownloadURL();
                    FirebaseFirestore.instance.collection("users")
                      .doc(user.uid).update({
                        "Photo" : downloadUrl
                      });
                  }catch(e) {
                    setState(() {
                      uploading = false;
                     });
                     showSimpleNotification(
                      Text("Failed"),
                      background: Color.fromRGBO(75, 0, 130, 1),
                      duration: Duration(seconds: 1),
                      subtitle: Text("Profile photo upload failed",
                        style: TextStyle(
                          color: Color.fromRGBO(255,40,147, 1)
                        ),
                      )
                     );
                  }
                  Navigator.of(context).pop();
                }
              } : null,
            ),
          ],
        )
      );
    } 
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(75, 0, 130, 1),
        ),
      ),
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Container(
            color: Colors.white,
            child: StreamBuilder<DocumentSnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  nameController.text = snapshot.data['Fullname'];
                  if(jsonDecode(snapshot.data['Followers']).length != 0){
                    List followers = jsonDecode(snapshot.data['Followers']);
                    if(followers.contains(user.uid)){
                      following = true;
                    }else{
                      following = false;
                    }
                  }
                }
                if(!snapshot.hasData){
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.0), bottomRight: Radius.circular(35.0)),
                      color: Colors.white
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Shimmer.fromColors(
                            child: CircleAvatar(
                              radius: 40.0,
                            ),
                            baseColor: Colors.grey[100], 
                            highlightColor: Colors.grey[300]
                          ),
                          title: Shimmer.fromColors(
                            child: Container(
                              height: 15.0,
                              color: Colors.white,
                            ),
                            baseColor: Colors.grey[100],
                            highlightColor: Colors.grey[300],
                          ),
                          subtitle: Shimmer.fromColors(
                            child: Container(
                              height: 15.0,
                              color: Colors.white,
                            ),
                            baseColor: Colors.grey[100],
                            highlightColor: Colors.grey[300],
                          ),
                        ),
                        SizedBox(
                          height: 40.0
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: Divider(
                            color: Color.fromRGBO(230, 230, 230, 1),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Shimmer.fromColors(
                                  child: Container(
                                    height: 15.0,
                                    width: 60.0,
                                    color: Colors.white,
                                  ),
                                  baseColor: Colors.grey[100],
                                  highlightColor: Colors.grey[300],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("POSTS")
                              ],
                            ),
                            VerticalDivider(
                              
                            ),
                            Column(
                              children: [
                                Shimmer.fromColors(
                                  child: Container(
                                    height: 15.0,
                                    width: 60.0,
                                    color: Colors.white,
                                  ),
                                  baseColor: Colors.grey[100],
                                  highlightColor: Colors.grey[300],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("FOLLOWING")
                              ],
                            ),
                            VerticalDivider(
                              
                            ),
                            Column(
                              children: [
                                Shimmer.fromColors(
                                  child: Container(
                                    height: 15.0,
                                    width: 60.0,
                                    color: Colors.white,
                                  ),
                                  baseColor: Colors.grey[100],
                                  highlightColor: Colors.grey[300],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("FOLLOWERS")
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Stack(
                              children: [
                                snapshot.data['Photo'].isEmpty ? CircleAvatar(
                                  radius: 40.0,
                                  child: Text(snapshot.data['Fullname'].toString().split(" ")[1][0],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40.0
                                    )
                                  )
                                ) : CachedNetworkImage(
                                  imageUrl: snapshot.data['Photo'],
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    );
                                  },
                                  placeholder: (context, url) => Shimmer.fromColors(
                                    child: CircleAvatar(
                                      radius: 25.0,
                                    ),
                                    baseColor: Colors.grey[100], 
                                    highlightColor: Colors.grey[300]
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red,),
                                ),
                                user.uid == widget.uId ? Padding(
                                  padding: EdgeInsets.fromLTRB(30.0, 35.0, 0.0, 0.0),
                                  child: IconButton(
                                    icon: Icon(CupertinoIcons.camera, color: Color.fromRGBO(180, 180, 180, 1),),
                                    onPressed: (){
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context){
                                          return SizedBox(
                                            height: 130.0,
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: Icon(CupertinoIcons.camera),
                                                  title: Text("Camera"),
                                                  onTap: () async {
                                                    if(await Permission.camera.isGranted){
                                                      uploadProfilePhoto(cameraSource);
                                                    }else{
                                                      await Permission.camera.request();
                                                      if(await Permission.camera.isGranted){
                                                        uploadProfilePhoto(cameraSource);
                                                      }
                                                    }
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(CupertinoIcons.photo),
                                                  title: Text("Gallery"),
                                                  onTap: () async {
                                                    if(await Permission.photos.isGranted){
                                                      uploadProfilePhoto(gallerySource);
                                                    }else{
                                                      await Permission.photos.request();
                                                      if(await Permission.photos.isGranted){
                                                        uploadProfilePhoto(gallerySource);
                                                      }
                                                    }
                                                  },
                                                )
                                              ],
                                            )
                                          );
                                        }
                                      );
                                    },
                                  ),
                                ) : Container()
                              ],
                            ),
                            title: Text(snapshot.data["Fullname"]),
                            subtitle: Text(snapshot.data["Email"]),
                            trailing: IconButton(
                              icon: widget.uId == user.uid ? Icon(Icons.edit, color: Color.fromRGBO(75, 0, 130, 1)) : Container(),
                              onPressed: () {
                                bool uploading = false;
                                showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                    title: new Text("Edit Fullname"),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return SizedBox(
                                          height: 50.0,
                                          child: uploading ? Center(
                                            child: CircularProgressIndicator(),
                                          ) : TextFormField(
                                            controller: nameController,
                                            enableSuggestions: true,
                                            cursorColor: Color.fromRGBO(255,40,147, 1),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              hintText: "Enter fullname"
                                            ),
                                          )
                                        );
                                      },
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Close',
                                          style: TextStyle(
                                            color: Color.fromRGBO(75, 0, 130, 1),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        color: Color.fromRGBO(75, 0, 130, 1),
                                        child: Text('Update',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: !uploading ? () async {
                                          if(user != null){
                                            try{
                                              uploading = true;
                                              FirebaseFirestore.instance.collection("users")
                                              .doc(user.uid).update({
                                                "Fullname" : nameController.text
                                              });
                                            }catch(e){
                                              uploading = false;
                                              showSimpleNotification(
                                                Text("Failed"),
                                                background: Color.fromRGBO(75, 0, 130, 1),
                                                duration: Duration(seconds: 1),
                                                subtitle: Text("Fullname update failed",
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(255,40,147, 1)
                                                  ),
                                                )
                                              );
                                            }
                                            Navigator.of(context).pop();
                                          }
                                        } : null,
                                      ),
                                    ],
                                  )
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.0
                          ),
                          followButtonVisible ? SizedBox(
                            height: 30.0,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                              child: RaisedButton(
                                color: Color.fromRGBO(230, 230, 230, 1),
                                shape: RoundedRectangleBorder(
                                  // borderRadius: new BorderRadius.circular(30.0),
                                  side: BorderSide(color: Color.fromRGBO(50,50,50, 1), width: 1.0),
                                ),
                                child: Center(
                                  child: Text(following ? "Unfollow" : "Follow"),
                                ),
                                onPressed: (){
                                  if(following){
                                    if(user != null){
                                      List userFollowers = jsonDecode(snapshot.data['Followers']);
                                      userFollowers.remove(user.uid);
                                      FirebaseFirestore.instance.collection("users")
                                        .doc(widget.uId).update({
                                          "Followers" : jsonEncode(userFollowers).toString()
                                        });
                                      List userFollowing = jsonDecode(snapshot.data['Following']);
                                      userFollowing.remove(widget.uId);
                                      FirebaseFirestore.instance.collection("users")
                                        .doc(user.uid).update({
                                          "Following" : jsonEncode(userFollowing).toString()
                                        });
                                      following = false;
                                    }
                                  }else{
                                    if(user != null){
                                      List userFollowers = jsonDecode(snapshot.data['Followers']);
                                      userFollowers.add(user.uid);
                                      FirebaseFirestore.instance.collection("users")
                                        .doc(widget.uId).update({
                                          "Followers" : jsonEncode(userFollowers).toString()
                                        });
                                      List userFollowing = jsonDecode(snapshot.data['Following']);
                                      userFollowing.add(widget.uId);
                                      FirebaseFirestore.instance.collection("users")
                                        .doc(user.uid).update({
                                          "Following" : jsonEncode(userFollowing).toString()
                                        });
                                      following = true;
                                    }
                                  }
                                },
                              ),
                            )
                          ) : Container(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            child: Divider(
                              color: Color.fromRGBO(230, 230, 230, 1),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(snapshot.data['NoPosts'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text("POSTS")
                                ],
                              ),
                              VerticalDivider(
                                
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => StreamUsers(
                                      title: "Following",
                                      uid: user.uid,
                                    )
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Text(jsonDecode(snapshot.data['Following']).length.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Text("FOLLOWING")
                                  ],
                                ),
                              ),
                              VerticalDivider(
                                
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => StreamUsers(
                                      title: "Followers",
                                      uid: user.uid,
                                    )
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Text(jsonDecode(snapshot.data['Followers']).length.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Text("FOLLOWERS")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      height: 15.0,
                    ),
                    Container(
                      height: 500.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.0), bottomRight: Radius.circular(35.0)),
                        color: Colors.white
                      ),
                      child: StreamBuilder(
                        stream: postStream,
                        builder: (context, snapshot){
                          if(!snapshot.hasData && (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active)){
                            return Container(
                              height: 500.0,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator()
                                  ],
                                ),
                              )
                            );
                          }
                          List<DocumentSnapshot> docs = snapshot.data.docs;
                          List<Widget> posts = docs.map((doc) => PostHandler(
                            comment: doc.get("comment"),
                            url: doc.get("photoLink"),
                          )).toList();
                          if(posts.length == 0){
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("No Posts",
                                    style: TextStyle(
                                      fontSize: 15.0
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(height: 10.0,),
                                  posts[(posts.length - 1) - index],
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                );
              }
            ),
          ),
        )
      )
    );
  }
}

class PostHandler extends StatefulWidget {
  const PostHandler({this.url, this.comment});


  @override
  _PostHandlerState createState() => _PostHandlerState();
  final String url;
  final String comment;
}

class _PostHandlerState extends State<PostHandler> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
      },
      child: CachedNetworkImage(
        imageUrl: widget.url,
        imageBuilder: (context, imageProvider){
          return Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain
              )
            ),
          );
        },
        placeholder: (context, url) => Shimmer.fromColors(
          child: Container(
            height: 100.0,
            width: 100.0,
          ),
          baseColor: Colors.grey[100], 
          highlightColor: Colors.grey[300]
        ),
        errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red,),
      )
    );
  }
}