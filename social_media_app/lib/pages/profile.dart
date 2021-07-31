import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/pages/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Future removeUserData() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setBool("login", false);
    userData.remove("firstname");
    userData.remove("lastname");
    userData.remove("email");
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          RaisedButton(
            onPressed: (){
              removeUserData();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                Auth()), (route) => false);
            },
          )
        ],
      ),
    );
  }
}
