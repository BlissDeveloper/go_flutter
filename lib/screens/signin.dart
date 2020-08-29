import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_flutter/model/routes.dart';
import 'package:go_flutter/res/constants.dart';
import 'package:go_flutter/res/my_colors.dart';
import 'package:go_flutter/res/strings.dart';
import 'package:go_flutter/res/styles.dart';
import 'package:go_flutter/services/firebaseutils.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, pass;

  bool isHidden = true, isLoading = false;

  FirebaseUtils firebaseUtils = FirebaseUtils();

  goToDashboard(context) {
    Navigator.pushReplacementNamed(context, Routes.DASH_BOARD_ROUTE);
  }

  goToSignUp(context) {
    Navigator.pushNamed(context, Routes.SIGN_UP_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.myBlue,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: isLoading,
                  child: LinearProgressIndicator(
                    backgroundColor: MyColors.myBlue,
                  ),
                ),
                Container(
                    color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 88.0, 16.0, 88.0),
                      child: Image.asset('assets/go.png'),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0),
                  child: TextFormField(
                      validator: (String value) {
                        if (value != null) {
                          if (Constants.emailRegExp.hasMatch(value)) {
                            return null;
                          } else {
                            return Strings.EMAIL_INVALID;
                          }
                        } else {
                          return Strings.EMAIL_INVALID;
                        }
                      },
                      onSaved: (value) {
                        email = value;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: MyStyles.styleTextField(
                          hint: Strings.EMAIL_HINT,
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: TextFormField(
                      validator: (String p) {
                        if (p.length > 0) {
                          return null;
                        } else {
                          return Strings.PASS_REQ;
                        }
                      },
                      onSaved: (value) {
                        pass = value;
                      },
                      obscureText: isHidden,
                      style: TextStyle(color: Colors.white),
                      decoration: new InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: Strings.PASS_HINT,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            icon: Icon(
                              isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48.0, 24.0, 48.0, 0.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          _formKey.currentState.save();
                          firebaseUtils
                              .signIn(email: email, pass: pass)
                              .then((isSuccessful) {
                            setState(() {
                              isLoading = false;
                            });
                            if (isSuccessful) {
                              goToDashboard(context);
                            } else {}
                          });
                        }
                      },
                      shape: MyStyles.styleButton(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          Strings.SIGN_IN,
                          style: MyStyles.styleButtonText(),
                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    goToSignUp(context);
                  },
                  child: Text(
                    Strings.DONT_HAVE_ACCOUNT,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
