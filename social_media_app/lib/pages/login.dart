import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/pages/home.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool _loading = false;
  bool _obscureText = true;

  String pwdValidator(String value) {
    if (value.isEmpty) {
      return '*Password cannot be empty';
    } else if(value.length < 8){
      return '*Password must 8 characters or more';
    }else {
      return null;
    }
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

  Future loginPersistence() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setBool("login", true);
  }

  Future login(String email, String password) async { 
    setState(() {
      _loading = true;
    });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      loginPersistence();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        HomePage()), (route) => false);
    }catch(e){
      setState(() {
        _loading = false;
      });
      switch(e.message){
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
          showSnackBar("Incorrect Username/Password");
          break;
        case "The password is invalid or the user does not have a password.":
          showSnackBar("Incorrect Username/Password");
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
    backgroundColor: Color.fromRGBO(250, 250, 250, 1),
    appBar: AppBar(
      elevation: 0.0,
      backgroundColor: Color.fromRGBO(75, 0, 130, 1)
    ),
    body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 270.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.0), bottomRight: Radius.circular(35.0)),
                  color: Color.fromRGBO(75, 0, 130, 1)
                ),
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          enableSuggestions: true,
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
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: new BorderRadius.circular(35.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: new BorderRadius.circular(35.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(75, 0, 130, 1)),
                              borderRadius: new BorderRadius.circular(35.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(75, 0, 130, 1)),
                              borderRadius: new BorderRadius.circular(35.0),
                            )
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
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: new BorderRadius.circular(35.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: new BorderRadius.circular(35.0),
                            ),
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
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(75, 0, 130, 1)),
                              borderRadius: new BorderRadius.circular(35.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(75, 0, 130, 1)),
                              borderRadius: new BorderRadius.circular(35.0),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17.5,
                  ),
                  Divider(
                    color: Color.fromRGBO(75, 0, 130, 1)
                  ),
                  SizedBox(
                    height: 17.5,
                  ),
                  SizedBox(
                    height: 55.0,
                    width: 400.0,
                    child: RaisedButton(
                      onPressed: ()  {
                        if(_formKey.currentState.validate()){
                          login(email, password);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        //side: BorderSide(color: Color.fromRGBO(237,47,89, 1)),
                      ),
                      color: Color.fromRGBO(75, 0, 130, 1),
                      child: _loading ? Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(255,40,147, 1)),
                          )
                        ) : Text("Sign In",
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
            )
          ],
        ),
      ),
    )
  );
  }
}