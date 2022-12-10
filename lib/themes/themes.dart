import 'package:flutter/material.dart';
import 'package:gym_app/themes/getThemes.dart';
import '../../constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  // indicates the current active theme
  bool get isDarkTheme => themeMode == ThemeMode.dark;

  // sets the new theme
  void setTheme(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  ///-light theme--------------------------------
  static final lightThemeData = ThemeData(
      brightness: Brightness.light,
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: accent,
            brightness: Brightness.light,
          ),
      scaffoldBackgroundColor: const Color(0xFFEFEFEF),
      canvasColor: l_canvas,
      primaryColor: accent,
      primaryColorLight: l_lightBackground,
      primaryColorDark: l_darkBackground,
      accentColor: accent,
      cardColor: l_icon,
      hintColor: l_hint,
      shadowColor: l_shadow,
      hoverColor: l_hover,
      iconTheme: GetThemes.getIconTheme(l_icon),
      toggleableActiveColor: accent,
      fontFamily: "Montserrat",
      textTheme: GetThemes.getTextTheme(l_heading, l_txt, l_btnTxt),
      elevatedButtonTheme:
          GetThemes.getElevatedBtnTheme(l_btn, l_shadow, l_btnTxt),
      appBarTheme:
          GetThemes.getAppBarTheme(l_darkBackground, l_heading, l_icon),
      inputDecorationTheme: GetThemes.getInputDecorationTheme(
          l_darkBackground, l_hint, l_hover, accent));

  ///-Dark theme------------------------------------------------
  static final darkThemeData = ThemeData(

      /// brightness
      brightness: Brightness.dark,

      /// colors
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: accent,
            brightness: Brightness.dark,
          ),
      canvasColor: d_canvas,
      primaryColorLight: d_lightBackground,
      primaryColorDark: d_darkBackground,
      accentColor: accent,
      cardColor: d_icon,
      hintColor: d_hint,
      shadowColor: d_shadow,
      errorColor: d_red,
      toggleableActiveColor: accent,

      /// font
      fontFamily: "Montserrat",

      // text
      textTheme: GetThemes.getTextTheme(d_heading, d_txt, d_btnTxt),

      // buttons
      buttonColor: d_btn,
      buttonTheme: null,
      textButtonTheme: null,
      elevatedButtonTheme:
          GetThemes.getElevatedBtnTheme(d_btn, d_shadow, d_btnTxt),
      outlinedButtonTheme: null,

      // switch
      switchTheme: null,

      // checkbox
      checkboxTheme: null,

      // cards
      cardTheme: null,

      // appBar
      appBarTheme:
          GetThemes.getAppBarTheme(d_darkBackground, d_heading, d_icon),

      // scrollbar
      scrollbarTheme: null,

      // floating action button
      floatingActionButtonTheme: null,

      // input decoration
      inputDecorationTheme: GetThemes.getInputDecorationTheme(
          d_lightBackground, d_hint, d_hover, accent));
}
