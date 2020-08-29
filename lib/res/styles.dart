import 'package:flutter/material.dart';
import 'package:go_flutter/res/my_colors.dart';

class MyStyles {
  static InputDecoration styleTextField({@required String hint, Icon icon}) {

    InputDecoration inputDecoration = new InputDecoration(
      labelStyle: TextStyle(color: Colors.white),
      labelText: hint,
      prefixIcon: icon,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
    );
    return inputDecoration;
  }

  static RoundedRectangleBorder styleButton() {
    RoundedRectangleBorder rectangleBorder = new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: MyColors.myRed));
    return rectangleBorder;
  }

  static TextStyle styleButtonText() {
    TextStyle textStyle = new TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0);

    return textStyle;
  }
}
