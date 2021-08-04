import 'package:flutter/material.dart';
import 'package:social_media_app/pages/feed.dart';
import 'package:social_media_app/pages/profile.dart';
import 'package:social_media_app/pages/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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

  final List<Widget> navWidgets = [
    Feed(),
    Search(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add_alt_1),
          label: "Profile"
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
