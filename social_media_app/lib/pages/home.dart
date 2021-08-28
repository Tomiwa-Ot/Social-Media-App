import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/pages/auth.dart';
import 'package:social_media_app/pages/bookmark.dart';
import 'package:social_media_app/pages/feed.dart';
import 'package:social_media_app/pages/profile.dart';
import 'package:social_media_app/pages/qr-code.dart';
import 'package:social_media_app/pages/search.dart';
import 'package:social_media_app/pages/settings_page.dart';
import 'package:social_media_app/pages/streamusers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
// add more Call search method from another class refresh data
class _HomePageState extends State<HomePage> {

  
  int _selectedIndex = 0;
  bool showSearchBar = false;
  bool showCancelSearch = false;
  String profilePhoto;
  TextEditingController searchController = new TextEditingController();
  PageController _pageController = PageController();
  FocusNode _focusNode = FocusNode();
  Stream<DocumentSnapshot> stream;
  User user = FirebaseAuth.instance.currentUser;

  void initState(){
    if(user != null){
      stream = FirebaseFirestore.instance.collection("users")
        .doc(user.uid).snapshots();
    }
    super.initState();
  }


  void _onItemTapped(int index){
    setState(() {
      index == 0 ? showSearchBar = false : showSearchBar = true;
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Future removeUserData() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setBool("login", false);
  }

  final List<Widget> navWidgets = [
    Feed(),
    Search(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: showSearchBar ? SizedBox(
          height: 53.0,
          child: TextFormField(
            controller: searchController,
            enableSuggestions: true,
            focusNode: _focusNode,
            maxLines: 1,
            minLines: 1,
            cursorColor: Color.fromRGBO(255,40,147, 1),
            decoration: InputDecoration(
              suffixIcon: showCancelSearch ? IconButton(
                icon: Icon(CupertinoIcons.xmark, color: Color.fromRGBO(75, 0, 130, 1)),
                onPressed: (){
                  searchController.clear();
                },
              ) : null,
              filled: true,
              fillColor: Color.fromRGBO(200, 200, 200, 1),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(200, 200, 200, 1), width: 2.0),
                borderRadius: BorderRadius.circular(15.0)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(200, 200, 200, 1), width: 2.0),
                borderRadius: BorderRadius.circular(15.0)
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(200, 200, 200, 1), width: 2.0),
                borderRadius: BorderRadius.circular(15.0)
              ),
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500
              )
            ),
            onChanged: (value) {
              
            },
          ),
        ) : null,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(75, 0, 130, 1),
        ),
      ) : null,
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: ListView(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: stream,
                    builder: (context, snapshot){
                      if(!snapshot.hasData){
                        return Column(
                          children: [
                            ListTile(
                              leading: Shimmer.fromColors(
                                child: CircleAvatar(
                                  radius: 25.0,
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
                            height: 20.0,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => StreamUsers(
                                          title: "Following", 
                                          uid: user.uid, 
                                        )
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Shimmer.fromColors(
                                            child: Container(
                                              height: 15.0,
                                              width: 10.0,
                                              color: Colors.white,
                                            ),
                                            baseColor: Colors.grey[100],
                                            highlightColor: Colors.grey[300],
                                          ),
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
                                    ),
                                  )
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => StreamUsers(
                                          title: "Followers", 
                                          uid: user.uid, 
                                        )
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Shimmer.fromColors(
                                            child: Container(
                                              height: 15.0,
                                              width: 10.0,
                                              color: Colors.white,
                                            ),
                                            baseColor: Colors.grey[100],
                                            highlightColor: Colors.grey[300],
                                          ),
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
                                    ),
                                  )
                                )
                              ],
                            )
                          )
                          ],
                        );
                      }
                      if(snapshot.hasData){
                        profilePhoto = snapshot.data['Photo'];
                      }
                      return Column(
                        children: [ 
                          ListTile(
                            leading: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Profile(
                                    uId: user.uid,
                                  )
                                ));
                              },
                              child: snapshot.data['Photo'].isEmpty ? CircleAvatar(
                                radius: 25.0,
                                child: Text(snapshot.data['Fullname'].toString().split(" ")[1][0],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.0
                                  ))
                                ) : CachedNetworkImage(
                                  imageUrl: snapshot.data['Photo'],
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      width: 60.0,
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    );
                                  },
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red,),
                                ),
                            ),
                            title: Text(snapshot.data['Fullname']),
                            subtitle: Text(snapshot.data['Email']),
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
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => StreamUsers(
                                          title: "Following", 
                                          uid: user.uid, 
                                        )
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(jsonDecode(snapshot.data['Following']).length.toString()),
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
                                    ),
                                  )
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => StreamUsers(
                                          title: "Followers", 
                                          uid: user.uid, 
                                        )
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(jsonDecode(snapshot.data['Followers']).length.toString()),
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
                                    ),
                                  )
                                )
                              ],
                            )
                          )
                        ],
                      );
                    },
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
                              builder: (context) => Profile(
                                uId: user.uid,
                              )
                            ));
                          },
                        ),
                        ListTile(
                          leading: Icon(CupertinoIcons.bookmark, color: Color.fromRGBO(75, 0, 130, 1)),
                          title: Text("Bookmark",
                            style: TextStyle(
                              fontSize: 17.0
                            ),
                          ),
                          onTap: () async{
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Bookmark()
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
                              builder: (context) => SettingsPage(
                                uid: user.uid,
                                isPhotoEmpty: profilePhoto.isEmpty,
                                profilePhoto: profilePhoto.isEmpty ? "" : profilePhoto,
                              )
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
                          builder: (context) => QrCode(uid: user.uid,)
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
