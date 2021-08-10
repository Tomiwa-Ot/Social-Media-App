import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/pages/streamusers.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

  Profile({this.uId, this.fullname, this.email}); 

  final String uId;
  final String fullname;
  final String email;
}

class _ProfileState extends State<Profile> {

  String firstname, lastname, email;
  bool followButtonVisible = false;
  User user = FirebaseAuth.instance.currentUser;
  Stream<DocumentSnapshot> stream;

  void initState(){
    if(user != null){
      stream = FirebaseFirestore.instance.collection("users")
        .doc(widget.uId).snapshots();
    }
    showFollowButton();
    super.initState();
  }

  void showFollowButton(){
    if(user.uid == widget.uId){
      setState(() {
        followButtonVisible = true;
      });
    }else{
      setState(() {
        followButtonVisible = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(75, 0, 130, 1),
        ),
      ),
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: Container(
        color: Colors.white,
        child: StreamBuilder<DocumentSnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(75, 0, 130, 1),
                      radius: 40.0,
                    ),
                    title: Text(snapshot.data["Fullname"]),
                    subtitle: Text(snapshot.data["Email"]),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Color.fromRGBO(75, 0, 130, 1)),
                      onPressed: (){

                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0
                  ),
                  followButtonVisible ? SizedBox(
                    height: 30.0,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RaisedButton(
                        child: Center(
                          child: Text("Follow"),
                        ),
                        onPressed: (){

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
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => StreamUsers(
                              title: "Following",
                              uid: user.uid,
                              users: snapshot.data['Following'],
                              streamUsers: false,
                            )
                          ));
                        },
                        child: Column(
                          children: [
                            Text(snapshot.data['Following'].length.toString(),
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
                            builder: (context) => StreamUsers(title: "Followers", uid: user.uid, users: snapshot.data['Following'], streamUsers: false,)
                          ));
                        },
                        child: Column(
                          children: [
                            Text(snapshot.data['Followers'].length.toString(),
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
                  )
                ],
              ),
            );
          },
        ),
      )
    );
  }
}


// Container(
//         color: Colors.white,
//           child: Column(
//             children: [
//               ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Color.fromRGBO(75, 0, 130, 1),
//                   radius: 40.0,
//                 ),
//                 title: Text("${widget.fullname}"),
//                 subtitle: Text("${widget.email}"),
//                 trailing: IconButton(
//                   icon: Icon(Icons.edit, color: Color.fromRGBO(75, 0, 130, 1)),
//                   onPressed: (){

//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 10.0
//               ),
//               followButtonVisible ? SizedBox(
//                 height: 30.0,
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
//                   child: RaisedButton(
//                     child: Center(
//                       child: Text("Follow"),
//                     ),
//                     onPressed: (){

//                     },
//                   ),
//                 )
//               ) : Container(),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
//                 child: Divider(
//                   color: Color.fromRGBO(230, 230, 230, 1),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) => StreamUsers(title: "Following", uid: "user id",)
//                       ));
//                     },
//                     child: Column(
//                       children: [
//                         Text("0",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0,
//                           ),
//                         ),
//                         Text("FOLLOWING")
//                       ],
//                     ),
//                   ),
//                   VerticalDivider(
                    
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) => StreamUsers(title: "Followers", uid: "user id",)
//                       ));
//                     },
//                     child: Column(
//                       children: [
//                         Text("0",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0,
//                           ),
//                         ),
//                         Text("FOLLOWERS")
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),