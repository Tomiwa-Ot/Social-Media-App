import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  FocusNode _focusNode = FocusNode();
  bool showCancelSearch = false;
  TextEditingController searchController = new TextEditingController();

  void initState(){
     _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        setState(() {
          showCancelSearch = true;
        });
      }else{
        setState(() {
          showCancelSearch = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose(){
    _focusNode.removeListener(() {});
    _focusNode.dispose();
    super.dispose();
  }

  setSearchParam(String value){
    List<String> cases = List();
    String temp = "";
    for(int i = 0; i < value.length; i++){
      temp = temp + value[i];
      cases.add(temp);
    }
    print(cases.toString());
    return cases;
  }

  Future search(List cases) async {
    if(user != null){
      FirebaseFirestore.instance.collection("users")
      .where("Fullname", arrayContainsAny: cases).get().then((value) {
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
                )
            ));
          },
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: searchResult.docs[index].data()['Photo'].isEmpty ? CircleAvatar(
                  radius: 25.0,
                  child: Text(searchResult.docs[index].data()['Fullname'].toString().split(" ")[1][0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0
                    )
                  )
                ) : CachedNetworkImage(
                  imageUrl: searchResult.docs[index].data()['Photo'],
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 25.0,
                      height: 25.0,
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: SizedBox(
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
                borderRadius: BorderRadius.circular(5.0)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(200, 200, 200, 1), width: 2.0),
                borderRadius: BorderRadius.circular(5.0)
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(200, 200, 200, 1), width: 2.0),
                borderRadius: BorderRadius.circular(5.0)
              ),
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500
              )
            ),
            onChanged: (value) {
              if(value.isNotEmpty){
                setState(() {
                  isSearching = true;
                });
                search(setSearchParam(value));
              }else{
                setState(() {
                  isSearching = false;
                });
              }
            },
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: isSearching ? (isSearchEmpty ? searchEmpty() : results()) : body(),
    );
  }
}