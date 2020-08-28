import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_flutter/model/routes.dart';
import 'package:go_flutter/res/constants.dart';
import 'package:go_flutter/res/strings.dart';
import 'package:go_flutter/singleton/user_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isHidden = true;
  bool isHidden2 = true;

  Future permission;
  Future firebaseInit;

  File legitImageFile;
  String firstName, lastName, desc;
  UserDetails userInfoSingleton = UserDetails();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    permission = checkPermissions();
  }

  checkPermissions() async {
    return await [
      Permission.storage,
    ].request();
  }

  initFirebase() async {
    return await Firebase.initializeApp();
  }

  openGallery() async {
    PickedFile imageFile;
    imageFile = await new ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      legitImageFile = File(imageFile.path);
    });
  }

  Widget determineAvatarState() {
    if (legitImageFile == null) {
      return CircleAvatar(
        radius: 72.0,
      );
    } else {
      return CircleAvatar(
        radius: 72.0,
        child: Image.file(
          legitImageFile,
          height: 72.0,
          width: 72.0,
        ),
      );
    }
  }

  goToNext(BuildContext context) {
    Navigator.pushNamed(context, Routes.SIGN_UP_ROUTE_2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.SIGN_UP),
        ),
        body: FutureBuilder(
          future: permission,
          builder: (context, snapshot) {
            Map<Permission, PermissionStatus> map = snapshot.data;
            print(map);
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container();
                break;
              case ConnectionState.done:
                firebaseInit = initFirebase();
                return FutureBuilder(
                  future: firebaseInit,
                  builder: (context, snap) {
                    switch (snap.connectionState) {
                      case ConnectionState.waiting:
                        return LinearProgressIndicator();
                        break;
                      case ConnectionState.done:
                        return Container(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      determineAvatarState(),
                                      IconButton(
                                        icon: Icon(Icons.add_a_photo),
                                        onPressed: () {
                                          openGallery();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  TextFormField(
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return Strings.FIRST_NAME_REQ;
                                      } else {
                                        if (Constants.nameRegExp
                                            .hasMatch(value)) {
                                          return Strings.NAME_NO_SPEC_CHAR;
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    onSaved: (String value) {
                                      firstName = value;
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: Strings.FIRST_NAME_HINT),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: Strings.LAST_NAME_HINT),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return Strings.LAST_NAME_REQ;
                                      } else {
                                        if (Constants.nameRegExp
                                            .hasMatch(value)) {
                                          return Strings.NAME_NO_SPEC_CHAR;
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    onSaved: (String value) {
                                      lastName = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  TextFormField(
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: Strings.DESC_HINT),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return Strings.DESC_REQ;
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (String value) {
                                      desc = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      child: Text(Strings.NEXT_HINT),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          userInfoSingleton.firstName =
                                              firstName;
                                          userInfoSingleton.lastName = lastName;
                                          userInfoSingleton.desc = desc;
                                          userInfoSingleton.localImageFile =
                                              legitImageFile;
                                          goToNext(context);
                                        } else {
                                          print("Bad");
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        break;
                      default:
                        return Text("Default");
                    }
                  },
                );
                break;
              default:
                return Text("Hello");
            }
          },
        ));
  }
}
