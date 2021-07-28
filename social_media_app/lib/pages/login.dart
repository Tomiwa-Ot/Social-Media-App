import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  TextFormField(
                    enableSuggestions: true,
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
                      // disabledColor: Colors.grey,
                      // disabledTextColor: Colors.black12,
                      onPressed: ()  {
                        
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        //side: BorderSide(color: Color.fromRGBO(237,47,89, 1)),
                      ),
                      color: Color.fromRGBO(75, 0, 130, 1),
                      child: Text("Sign In",
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