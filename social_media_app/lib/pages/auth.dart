import 'package:social_media_app/pages/login.dart';
import 'package:social_media_app/pages/register.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  int _selectedIndex = 0;
  final List<Widget> navWidgets = [
    Login(),
    Register()
  ];
  

   void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: navWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.vpn_key_rounded),
          label: "Sign In",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add_alt_1),
          label: "Sign Up"
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