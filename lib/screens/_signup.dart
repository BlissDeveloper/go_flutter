import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_flutter/model/routes.dart';
import 'package:go_flutter/res/constants.dart';
import 'package:go_flutter/res/my_colors.dart';
import 'package:go_flutter/res/strings.dart';
import 'package:go_flutter/res/styles.dart';
import 'package:go_flutter/services/firebaseutils.dart';
import 'package:go_flutter/singleton/user_info.dart';

class SignUp2 extends StatefulWidget {
  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  bool isHidden = true;
  bool isHidden2 = true;

  TextEditingController passCon = new TextEditingController();

  UserDetails userInfoSingleton = UserDetails();

  String email, password, confirmPass;

  GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  FirebaseUtils firebaseUtils;

  bool isLoading = false;

  goToDashboard(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, Routes.DASH_BOARD_ROUTE);
  }

  initProcess() {
    setState(() {
      isLoading = true;
    });
    userInfoSingleton.email = email;
    firebaseUtils.registerToAuth(email, password).then((success) {
      if (success) {
        firebaseUtils.logUser(email, password).then((uid) {
          firebaseUtils
              .uploadImage(userInfoSingleton.localImageFile)
              .then((imageUrl) {
            if (uid != null) {
              userInfoSingleton.serverImageUri = imageUrl;
              userInfoSingleton.uid = uid;
              firebaseUtils
                  .uploadUserInfo(userInfoSingleton)
                  .then((isSuccessful) {
                setState(() {
                  isLoading = false;
                });
                if (isSuccessful) {
                  print("Upload success");
                  goToDashboard(context);
                } else {}
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
          });
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    firebaseUtils = new FirebaseUtils();

    return Scaffold(
      backgroundColor: MyColors.myBlue,
      appBar: AppBar(
        elevation: 0,
        title: Text(Strings.SIGN_UP),
      ),
      body: Container(
        child: Form(
          key: _formStateKey,
          child: Column(
            children: <Widget>[
              Visibility(
                child: LinearProgressIndicator(),
                visible: isLoading,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: MyStyles.styleTextField(hint: Strings.EMAIL_HINT),
                  validator: (String value) {
                    if (value != null) {
                      if (!Constants.emailRegExp.hasMatch(value)) {
                        return Strings.EMAIL_INVALID;
                      } else {
                        return null;
                      }
                    } else {
                      return Strings.EMAIL_INVALID;
                    }
                  },
                  onSaved: (String value) {
                    email = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: passCon,
                  obscureText: isHidden,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.PASS_HINT,
                      suffixIcon: IconButton(
                        color: Colors.white,
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
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      labelStyle: TextStyle(color: Colors.white)),
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  obscureText: isHidden2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.PASS_CONFIRM_HINT,
                      suffixIcon: IconButton(
                        color: Colors.white,
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
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      labelStyle: TextStyle(color: Colors.white)),
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(48.0, 16.0, 48.0, 0.0),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: MyStyles.styleButton(),
                    child: Text(
                      Strings.SUBMIT_HINT,
                      style: MyStyles.styleButtonText(),
                    ),
                    onPressed: () {
                      if (_formStateKey.currentState.validate()) {
                        _formStateKey.currentState.save();
                        initProcess();
                      } else {
                        print("Bad");
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
