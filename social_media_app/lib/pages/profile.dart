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
//FETCH NAME FROM SHARED PREF


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(75, 0, 130, 1),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Color.fromRGBO(75, 0, 130, 1)),
            onPressed: (){
              removeUserData();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                Auth()), (route) => false);
            },
          )
        ],
      ),
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: Container(
        color: Colors.white,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromRGBO(255,40,147, 1),
                  radius: 40.0,
                ),
                title: Text("Firstname Lastname"),
                subtitle: Text("email@email.com"),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Color.fromRGBO(75, 0, 130, 1)),
                  onPressed: (){

                  },
                ),
              ),
              SizedBox(
                height: 10.0
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
                      Text("0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color.fromRGBO(75, 0, 130, 1)
                        ),
                      ),
                      Text("FOLLOWING")
                    ],
                  ),
                  VerticalDivider(
                    
                  ),
                  Column(
                    children: [
                      Text("0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color.fromRGBO(75, 0, 130, 1)
                        ),
                      ),
                      Text("FOLLOWERS")
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
}
