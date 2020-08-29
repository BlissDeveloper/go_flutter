import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_flutter/model/routes.dart';
import 'package:go_flutter/res/my_colors.dart';
import 'package:go_flutter/res/strings.dart';
import 'package:go_flutter/services/firebaseutils.dart';
import 'package:go_flutter/singleton/user_info.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseUtils firebaseUtils = new FirebaseUtils();

  Future getUserDetails() async {
    return await firebaseUtils.getUserInfo();
  }

  void showAlert(context) {
    showDialog(
        context: context,
        builder: (BuildContext con) {
          return AlertDialog(
            title: Text(Strings.SIGN_OUT),
            content: Text(Strings.SIGN_OUT_MESSAGE),
            actions: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text(
                  Strings.NO,
                  style: TextStyle(color: MyColors.myRed),
                ),
              ),
              FlatButton(
                onPressed: () {
                  firebaseUtils.signOut().then((value) {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, Routes.SIGN_UP_ROUTE);
                  });
                },
                child: Text(
                  Strings.YES,
                  style: TextStyle(color: MyColors.myRed),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUtils firebaseUtils = new FirebaseUtils();

    return Scaffold(
      backgroundColor: MyColors.myBlue,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showAlert(context);
            },
            color: Colors.white,
            icon: Icon(
              Icons.exit_to_app,
            ),
          )
        ],
        elevation: 0,
        title: Text(Strings.DASH_BOARD),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return LinearProgressIndicator();
              break;
            case ConnectionState.done:
              Future getDetails = getUserDetails();
              return FutureBuilder(
                future: getDetails,
                builder: (context, snap) {
                  switch (snap.connectionState) {
                    case ConnectionState.waiting:
                      return LinearProgressIndicator();
                      break;
                    case ConnectionState.done:
                      UserDetails userDetails = snap.data;
                      return UserCard(userDetails);
                      break;
                    default:
                      return Text("Default");
                  }
                },
              );
              break;
            default:
              return Text("Default");
          }
        },
      ),
    );
  }
}

class UserCard extends StatefulWidget {
  @override
  _UserCardState createState() => _UserCardState();

  UserDetails userDetails;

  UserCard(this.userDetails);
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    UserDetails userDetails = widget.userDetails;
    return Column(
      children: <Widget>[
        Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Image.asset('assets/go.png'),
            )),
        Container(
          width: double.infinity,
          color: MyColors.myRed,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(userDetails.serverImageUri),
                backgroundColor: Colors.white,
                radius: 88.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                userDetails.firstName + " " + userDetails.lastName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    userDetails.email,
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userDetails.desc,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
