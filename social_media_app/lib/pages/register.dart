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
  String firstname, lastname, email, password;

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

  Future loginPersistence(String firstname, String lastname, String email) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setBool("login", true);
    userData.setString("firstname", firstname);
    userData.setString("lastname", lastname);
    userData.setString("email", email);
  }

  Future registerUser(String firstname, String lastname, String email, String password) async {
    UserCredential createdUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    if(createdUser.user != null){
      FirebaseFirestore.instance.collection("users").doc(createdUser.user.uid).set({
        "Firstname" : firstname,
        "Lastname" : lastname,
        "Email" : email
      });
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(user != null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomePage()), (route) => false);
      }else{
        showDialog(
          context: context,
          builder: (_) => new AlertDialog(
            title: new Text("Oops"),
            content: new Text("Registration Failed"),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context, rootNavigator:true).pop();
                },
              )
            ],
          )
        );
      }
    }else{
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Oops"),
          content: new Text("Something went wrong"),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context, rootNavigator:true).pop();
              },
            )
          ],
        )
      );
    }
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: TextFormField(
                                  enableSuggestions: true,
                                  validator: nameValidator,
                                  onChanged: (value) => firstname = value,
                                  cursorColor: Color.fromRGBO(255,40,147, 1),
                                  decoration: new InputDecoration(
                                    labelText: "\t\tFirstname",
                                    labelStyle: TextStyle(
                                      color: Colors.grey
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Flexible(
                                child: TextFormField(
                                  enableSuggestions: true,
                                  validator: nameValidator,
                                  onChanged: (value) => lastname = value,
                                  cursorColor: Color.fromRGBO(255,40,147, 1),
                                  decoration: new InputDecoration(
                                    labelText: "\t\tLastname",
                                    labelStyle: TextStyle(
                                      color: Colors.grey
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                            obscureText: true,
                            cursorColor: Color.fromRGBO(255,40,147, 1),
                            decoration: new InputDecoration(
                              labelText: "Password",
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
                            registerUser(firstname, lastname, email, password);
                          }
                        } : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Color.fromRGBO(75, 0, 130, 1),
                        child: Text("Sign Up",
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