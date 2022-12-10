import 'package:flutter/material.dart';
import '../constants.dart' as constants;

class GetThemes {
  /// text theme
  static TextTheme getTextTheme(headingColor, txtColor, btnTxt) => TextTheme(
        headline1: TextStyle(
            fontSize: 80.0, fontWeight: FontWeight.w300, color: headingColor),
        headline2: TextStyle(
            fontSize: 60.0, fontWeight: FontWeight.w300, color: headingColor),
        headline3: TextStyle(
            fontSize: 48.0, fontWeight: FontWeight.w400, color: headingColor),
        headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400),
        headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
        subtitle1: TextStyle(
            fontFamily: "Georgia",
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: headingColor,
            decoration: TextDecoration.underline),
        subtitle2: TextStyle(
            fontFamily: "Georgia",
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: constants.accent,
            decoration: TextDecoration.underline),
        bodyText1: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontFamily: "Hind",
            color: txtColor),
        bodyText2: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontFamily: "Hind",
            color: txtColor),
        button: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w500, color: btnTxt),
      );

  /// elevated button
  static ElevatedButtonThemeData getElevatedBtnTheme(
          btnColor, shadowColor, btnTxt) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: constants.accent,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            minimumSize: Size(double.infinity, 50),
            shadowColor: shadowColor,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
      );

  static AppBarTheme getAppBarTheme(bgColor, headingColor, iconColor) =>
      AppBarTheme(
        backgroundColor: bgColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: iconColor,
          size: 30.0,
        ),
        actionsIconTheme: IconThemeData(
          color: iconColor,
          size: 30.0,
        ),
        textTheme: TextTheme(
            headline1: TextStyle(
                //fontSize: 80.0,
                fontWeight: FontWeight.w300,
                color: headingColor)),
      );

  static IconThemeData getIconTheme(iconColor) => IconThemeData(
        color: iconColor,
        size: 30.0,
      );

  static InputDecorationTheme getInputDecorationTheme(
          bgColor, hintColor, hoverColor, accent) =>
      InputDecorationTheme(
        labelStyle:
            TextStyle(color: hintColor, decoration: TextDecoration.none),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: accent)),
        filled: true,
        fillColor: bgColor,
        hoverColor: hoverColor,
      );
}
