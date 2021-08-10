import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/pages/profile.dart';


class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  User user = FirebaseAuth.instance.currentUser;
  bool isSearchEmpty = true;
  bool isSearching = false;
  QuerySnapshot searchResult;

  Future search(String value) async {
    if(user != null){
      FirebaseFirestore.instance.collection("users")
      .where("Fullname", isGreaterThanOrEqualTo: value).get().then((value) {
        if(value.docs.isNotEmpty){
          setState(() {
            print("not empty");
            searchResult = value;
            isSearchEmpty = false;
          });
        }else{
          print("empty");
          setState(() {
            isSearchEmpty = true;
          });
        }
      });
    }
  }
  
  Widget searchEmpty(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("No Results")
        ],
      ),
    );
  }

  Widget results(){
    return ListView.builder(
      itemCount: searchResult.docs.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => Profile(                  
                  uId: searchResult.docs[index].data()['ID'],  
                  fullname: searchResult.docs[index].data()['Fullname'], 
                  email: searchResult.docs[index].data()['Email'], 
                )
            ));
          },
          child: Column(
            children: [
               ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(75, 0, 130, 1),
                    radius: 40.0,
                  ),
                  title: Text(searchResult.docs[index].data()['Fullname']),
                ),
                SizedBox(height: 5.0),
                Divider()
            ],
          )
        );
      },
    );
  }

  Widget body(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Body",
            style: TextStyle(
              fontSize: 20.0
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: isSearching ? (isSearchEmpty ? searchEmpty() : results()) : body(),
    );
  }
}