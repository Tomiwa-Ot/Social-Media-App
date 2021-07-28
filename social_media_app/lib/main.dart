import 'package:social_media_app/pages/auth.dart';
import 'package:social_media_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  SharedPreferences data;
  bool _isLoggedIn = false;

  Future checkIfLogin() async {
    data = await SharedPreferences.getInstance();
    bool _val = data.getBool("login");
    if(_val == true){
      setState(() {
        _isLoggedIn = !_isLoggedIn;
      });
    }
  }

  void initState(){
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        home: _isLoggedIn ? HomePage() : Auth(),
        color: Color.fromRGBO(75, 0, 130, 1),
      )
    );
  }
}
