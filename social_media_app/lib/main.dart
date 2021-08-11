import 'package:firebase_core/firebase_core.dart';
import 'package:social_media_app/pages/auth.dart';
import 'package:social_media_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(StartPage());
}


class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  SharedPreferences data;
  bool _isLoggedIn = false;
  String fullname, email, photo;

  Future<FirebaseApp> initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Future checkIfLogin() async {
    data = await SharedPreferences.getInstance();
    bool _val = data.getBool("login");
    if(_val == true){
      setState(() {
        fullname = data.getString("fullname");
        email = data.getString("email");
        photo = data.getString("photo");
        _isLoggedIn = !_isLoggedIn;
      });
    }
  }

  void initState(){
    initializeFirebase();
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Social Media App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _isLoggedIn ? HomePage(fullname: fullname, email: email, photo: photo,) : Auth(),
        color: Color.fromRGBO(75, 0, 130, 1),
      )
    );
  }
}
