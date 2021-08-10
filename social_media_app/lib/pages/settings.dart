import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/pages/auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();

  Settings({this.uid});

  final String uid;
}

class _SettingsState extends State<Settings> {

  int rating = 0;

  _launchURL(String url) async{
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

  Future removeUserData() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setBool("login", false);
    userData.remove("fullname");
    userData.remove("email");
  }

  Future deleteUser() async {
    try{
      FirebaseAuth.instance.signOut();
      FirebaseFirestore.instance.collection("users").doc(widget.uid).delete();
      removeUserData();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        Auth()), (route) => false);
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Settings",
          style: TextStyle(
            color: Color.fromRGBO(75, 0, 130, 1),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(75, 0, 130, 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:15.0),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Account"),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              color: Colors.white,
              child: Column(
                children: [  
                  ListTile(
                    title: Text("Contact Us"),
                    onTap: () {
                      _launchURL("https://tomiwa.com.ng/");
                    },
                  ),
                  Divider(height:1.0),
                  ListTile(
                    title: Text("Help Center (FAQs)"),
                    onTap: () {
            
                    },
                  ),
                  Divider(height:1.0),
                  ListTile(
                    title: Text("Delete Account"),
                    onTap: () {
                      deleteUser();
                    },
                  ),
                  Divider(height:1.0),
                ],
              )
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("General"),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: Text("Terms of Service"),
                    onTap: () {
                      _launchURL("https://github.com/Tomiwa-Ot/Social-Media-App/LICENSE.txt");
                    },
                  ),
                  Divider(height:1.0),
                  ListTile(
                    title: Text("Privacy"),
                    onTap: () {
                      
                    },
                  ),
                  Divider(height:1.0),
                  ListTile(
                    title: Text("About"),
                    onTap: () {
                      _launchURL("https://github.com/Tomiwa-Ot/Social-Media-App");
                    },
                  ),
                  Divider(height:1.0),
                  ListTile(
                    title: Text("Rate the app"),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                          title: new Text("Rate App"),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: IconButton(
                                  icon: Icon(rating >=1 ? Icons.star : Icons.star_border_outlined, color: Color.fromRGBO(75, 0, 130, 1), size: 35.0,),
                                  onPressed: (){

                                  },
                                )
                              ),
                              Flexible(
                                child: IconButton(
                                  icon: Icon(rating >=2 ? Icons.star : Icons.star_border_outlined, color: Color.fromRGBO(75, 0, 130, 1), size: 35.0,),
                                  onPressed: (){
                                    setState(() {
                                      rating = 2;
                                    });
                                  },
                                )
                              ),
                              Flexible(
                                child: IconButton(
                                  icon: Icon(rating >=3 ? Icons.star : Icons.star_border_outlined, color: Color.fromRGBO(75, 0, 130, 1), size: 35.0,),
                                  onPressed: (){
                                    setState(() {
                                      rating = 3;
                                    });
                                  },
                                )
                              ),
                              Flexible(
                                child: IconButton(
                                  icon: Icon(rating >=4 ? Icons.star : Icons.star_border_outlined, color: Color.fromRGBO(75, 0, 130, 1), size: 35.0,),
                                  onPressed: (){
                                    setState(() {
                                      rating = 4;
                                    });
                                  },
                                )
                              ),
                              Flexible(
                                child: IconButton(
                                  icon: Icon(rating >=5 ? Icons.star : Icons.star_border_outlined, color: Color.fromRGBO(75, 0, 130, 1), size: 35.0,),
                                  onPressed: (){
                                    setState(() {
                                      rating = 5;
                                    });
                                  },
                                )
                              ),
                            ],
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
                              child: Text('Submit',
                                style: TextStyle(
                                  color: Color.fromRGBO(75, 0, 130, 1),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      );
                    },
                  ),
                  Divider(height:1.0),
                ],
              )
            ),
            SizedBox(height: 10.0),
          ],
        )
      ),
    );
  }
}