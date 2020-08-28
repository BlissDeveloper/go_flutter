import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_flutter/res/constants.dart';
import 'package:go_flutter/res/strings.dart';
import 'package:go_flutter/singleton/user_info.dart';

class SignUp2 extends StatefulWidget {
  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  bool isHidden = true;
  bool isHidden2 = true;

  TextEditingController passCon = new TextEditingController();

  UserInfo userInfoSingleton = UserInfo();

  String email, password, confirmPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.SIGN_UP),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: Strings.EMAIL_HINT),
                validator: (String value) {
                  if(!Constants.emailRegExp.hasMatch(value)) {

                  }
                  else {

                  }
                },
                onSaved: (String value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: passCon,
                maxLength: 6,
                obscureText: isHidden,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: Strings.PASS_HINT,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isHidden) {
                            isHidden = false;
                          } else {
                            isHidden = true;
                          }
                        });
                      },
                    )),
                validator: (String value) {
                  if (value.isEmpty) {
                    return Strings.PASS_REQ;
                  } else {
                    return null;
                  }
                },
                onSaved: (String value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                maxLength: 6,
                obscureText: isHidden2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: Strings.PASS_CONFIRM_HINT,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isHidden2 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isHidden2) {
                            isHidden2 = false;
                          } else {
                            isHidden2 = true;
                          }
                        });
                      },
                    )),
                validator: (String value) {
                  if (value.isEmpty) {
                    return Strings.CONFIRM_PASS_REQ;
                  } else {
                    if (value != passCon.text) {
                      return Strings.PASS_NOT_MATCHED;
                    } else {
                      return null;
                    }
                  }
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text(Strings.NEXT_HINT),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
