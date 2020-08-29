import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_flutter/res/my_colors.dart';
import 'package:go_flutter/screens/dashboard.dart';
import 'package:go_flutter/screens/signin.dart';
import 'package:go_flutter/screens/signup.dart';
import 'package:go_flutter/screens/_signup.dart';
import 'package:go_flutter/services/firebaseutils.dart';

import 'model/routes.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return MaterialApp(
                home: Scaffold(
              body: LinearProgressIndicator(),
            ));
            break;
          case ConnectionState.done:
            return MaterialApp(
              theme: ThemeData(
                  primaryColor: MyColors.myRed,
                  accentColor: Colors.redAccent,
                  cursorColor: Colors.white,
                  buttonTheme: ButtonThemeData(
                    buttonColor: MyColors.myRed,
                  )),
              routes: {
                Routes.SIGN_UP_ROUTE: (context) => SignUp(),
                Routes.SIGN_IN_ROUTE: (context) => SignIn(),
                Routes.SIGN_UP_ROUTE_2: (context) => SignUp2(),
                Routes.DASH_BOARD_ROUTE: (context) => Dashboard(),
              },
              home: Wrapper(),
            );
            break;
          default:
            return Text("Hello");
        }
      },
    );
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  FirebaseUtils firebaseUtils = new FirebaseUtils();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return determineHome();
  }

  Widget determineHome() {
    if (firebaseUtils.getCurrentUser() != null) {
      //May naka-sign in na
      print("Already signed in");
      return Dashboard();
    } else {
      //Wala pa
      print("No on is signed in");
      return SignIn();
    }
  }
}
