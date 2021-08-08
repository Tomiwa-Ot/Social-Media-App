import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  bool isSearchEmpty = false;
  bool isSearching = false;
  QuerySnapshot searchResult;

  Future search(String value) async {
    FirebaseFirestore.instance.collection("users")
    .where("Fullname", isGreaterThanOrEqualTo: value).get().then((value) {
      if(value.docs.isNotEmpty){
        setState(() {
          searchResult = value;
          isSearchEmpty = true;
        });
      }else{
        setState(() {
          isSearchEmpty = false;
        });
      }
    });
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
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromRGBO(75, 0, 130, 1),
            radius: 40.0,
          ),
          title: Text(searchResult.docs[index].data()['Fullname']),
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