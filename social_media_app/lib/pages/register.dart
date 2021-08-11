import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/pages/home.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  String fullname, email, password;
  bool _loading = false;
  bool _obscureText = true;

  bool _checkBoxValue = false;
  void checkBoxState(){
    _checkBoxValue = !_checkBoxValue;
  }

  String pwdValidator(String value) {
    if (value.isEmpty) {
      return '*Password cannot be empty';
    } else if(value.length < 8){
      return '*Password must 8 characters or more';
    }else {
      return null;
    }
  }

  String nameValidator(String value){
    Pattern pattern =
        r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return '*Enter a valid name';
    else
      return null;
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }

  Future loginPersistence(String fullname, String email, String photo) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setBool("login", true);
    userData.setString("fullname", fullname);
    userData.setString("email", email);
    userData.setString("photo", photo);
  }

  Future registerUser(String fullname, String email, String password) async {
    setState(() {
      _loading = true;
    });
    try{
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      UserCredential createdUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(createdUser != null){
        FirebaseFirestore.instance.collection("users").doc(createdUser.user.uid).set({
          "ID" : createdUser.user.uid,
          "Fullname" : fullname,
          "Email" : email,
          "Bio" : "",
          "Photo" : "",
          "Following" : [].toString(),
          "Followers" : [].toString()
        });
      }
      loginPersistence(fullname, email, "");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomePage(fullname: fullname, email: email, photo: "",)), (route) => false);
    }catch(e){
      setState(() {
        _loading = false;
      });
      print(e.message);
      switch(e){
        case "The email address is already in use by another account.":
          showSnackBar("Email is registered to another account");
          break;
        default:
          showSnackBar("Something went wrong");
      }
    }
    
  }

  void showSnackBar(String value){
    Scaffold.of(context).showSnackBar(new SnackBar(
      backgroundColor: Color.fromRGBO(255,40,147, 1),
      duration: Duration(seconds: 4),
      elevation: 5.0,
      content: Text(value,
      textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.white
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(75, 0, 130, 1),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(75, 0, 130, 1)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Container(
              height: 650.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35.0), topRight: Radius.circular(35.0)),
                color: Color.fromRGBO(250, 250, 250, 1)
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            enableSuggestions: true,
                            validator: nameValidator,
                            onChanged: (value) => fullname = value,
                            keyboardType: TextInputType.name,
                            cursorColor: Color.fromRGBO(255,40,147, 1),
                            decoration: new InputDecoration(
                              labelText: "Fullname",
                              prefixIcon: Icon(
                                Icons.person_outline_outlined,
                                color: Color.fromRGBO(255,40,147, 1),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            enableSuggestions: false,
                            validator: emailValidator,
                            onChanged: (value) => email = value,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Color.fromRGBO(255,40,147, 1),
                            decoration: new InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.alternate_email_rounded,
                                color: Color.fromRGBO(255,40,147, 1),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            enableSuggestions: false,
                            validator: pwdValidator,
                            onChanged: (value) => password = value,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            cursorColor: Color.fromRGBO(255,40,147, 1),
                            decoration: new InputDecoration(
                              labelText: "Password",
                              suffixIcon: IconButton(
                                icon : Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: _obscureText ? Colors.grey : Color.fromRGBO(255,40,147, 1),
                                ),
                                onPressed: (){
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Color.fromRGBO(255,40,147, 1),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          value: _checkBoxValue,
                          activeColor: Color.fromRGBO(255,40,147, 1),
                          onChanged: (_checkBoxValue){
                            setState(() {
                              checkBoxState();
                            });
                          },
                        ),
                        Text("Agree to our Terms & Conditions"),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 55.0,
                      width: 400.0,
                      child: RaisedButton(
                        // disabledColor: Colors.grey,
                        // disabledTextColor: Colors.black12,
                        onPressed: _checkBoxValue ? () {
                          if(_formKey.currentState.validate()){
                            registerUser(fullname, email, password);
                          }
                        } : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Color.fromRGBO(75, 0, 130, 1),
                        child: _loading ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(255,40,147, 1),),
                          ),
                        ) : Text("Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Spartan',
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}