import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool _checkBoxValue = false;
  void checkBoxState(){
    _checkBoxValue = !_checkBoxValue;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextFormField(
                            enableSuggestions: true,
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
                          
                        } : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          //side: BorderSide(color: Color.fromRGBO(237,47,89, 1)),
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