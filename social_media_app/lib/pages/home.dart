import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/pages/auth.dart';
import 'package:social_media_app/pages/feed.dart';
import 'package:social_media_app/pages/post-drafts.dart';
import 'package:social_media_app/pages/profile.dart';
import 'package:social_media_app/pages/qr-code.dart';
import 'package:social_media_app/pages/search.dart';
import 'package:social_media_app/pages/settings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  // HomePage({this.uid});

  // final String uid;
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Future removeUserData() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setBool("login", false);
    userData.remove("firstname");
    userData.remove("lastname");
    userData.remove("email");
  }

  final List<Widget> navWidgets = [
    Feed(),
    Search(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(75, 0, 130, 1),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: ListView(
                children: [
                  ListTile(
                    leading: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Profile()
                        ));
                      },
                      child: CircleAvatar(
                        radius: 25.0,
                      ),
                    ),
                    title: Text("Firstname Lastname"),
                    subtitle: Text("email@email.com"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text("230"),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Flexible(
                                child: Text("Following",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text("168"),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Flexible(
                                child: Text("Followers",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ],
                          )
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person_outline, color: Color.fromRGBO(75, 0, 130, 1)),
                          title: Text("Profile",
                            style: TextStyle(
                              fontSize: 17.0
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Profile()
                            ));
                          },
                        ),
                        ListTile(
                          leading: Icon(CupertinoIcons.doc_plaintext, color: Color.fromRGBO(75, 0, 130, 1)),
                          title: Text("Drafts",
                            style: TextStyle(
                              fontSize: 17.0
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Drafts()
                            ));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings_outlined, color: Color.fromRGBO(75, 0, 130, 1)),
                          title: Text("Settings",
                            style: TextStyle(
                              fontSize: 17.0
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Settings()
                            ));
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Divider(),
                  ListTile(
                    leading: Icon(CupertinoIcons.square_arrow_right, color: Color.fromRGBO(75, 0, 130, 1)),
                    title: Text("Logout",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(CupertinoIcons.qrcode, color: Color.fromRGBO(75, 0, 130, 1)),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => QrCode()
                        ));
                      },
                    ),
                    onTap: () async {
                      removeUserData();
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        Auth()), (route) => false);
                    },
                  ),
                ],
              )
            )
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: navWidgets,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search"
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(75, 0, 130, 1),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey
        ),
        onTap: _onItemTapped,
      ),
    );
  }
}
