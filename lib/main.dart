import 'package:flutter/material.dart';
import 'package:go_flutter/screens/signin.dart';
import 'package:go_flutter/screens/signup.dart';
import 'package:go_flutter/screens/_signup.dart';

import 'model/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Routes.SIGN_UP_ROUTE: (context) => SignUp(),
        Routes.SIGN_UP_ROUTE: (context) => SignIn(),
        Routes.SIGN_UP_ROUTE_2: (context) => SignUp2()
      },
      home: SignUp(),
    );
  }
}
