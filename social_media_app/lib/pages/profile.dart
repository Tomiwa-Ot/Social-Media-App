import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/pages/streamusers.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String firstname, lastname, email;

  void initState(){
    //getUserData();
    super.initState();
  }

  void getUserData() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    firstname = userData.getString("firstname");
    lastname = userData.getString("lastname");
    email = userData.getString("email");
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
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromRGBO(75, 0, 130, 1),
                  radius: 40.0,
                ),
                title: Text("lastname firstname"),
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
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => StreamUsers(title: "Following", uid: "user id",)
                      ));
                    },
                    child: Column(
                      children: [
                        Text("0",
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
                        builder: (context) => StreamUsers(title: "Followers", uid: "user id",)
                      ));
                    },
                    child: Column(
                      children: [
                        Text("0",
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
        ),
    );
  }
}
