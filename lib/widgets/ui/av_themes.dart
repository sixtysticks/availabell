// Dependency imports
import 'package:flutter/material.dart';

// Availabell imports
import 'package:availabell/widgets/misc/globals.dart' as globals;

class AVThemes {
  static final Map<int, Color> avPrimarySwatch = {
    50: Color.fromRGBO(0, 173, 181, .1),
    100: Color.fromRGBO(0, 173, 181, .2),
    200: Color.fromRGBO(0, 173, 181, .3),
    300: Color.fromRGBO(0, 173, 181, .4),
    400: Color.fromRGBO(0, 173, 181, .5),
    500: Color.fromRGBO(0, 173, 181, .6),
    600: Color.fromRGBO(0, 173, 181, .7),
    700: Color.fromRGBO(0, 173, 181, .8),
    800: Color.fromRGBO(0, 173, 181, .9),
    900: Color.fromRGBO(0, 173, 181, 1),
  };

  static final MaterialColor avPrimaryColor = MaterialColor(0xFF00adb5, avPrimarySwatch);
  static final Color avDarkColor = Color.fromRGBO(58, 58, 58, 1.0);
  static final Color avLightColor = Colors.white; // #fff
  static final Color avPinkColor = Color.fromRGBO(249, 66, 102, 1.0);
  static final Color avBlueColor = Color.fromRGBO(57, 160, 237, 1.0);
  static final Color avGreyColor = Color.fromRGBO(186, 186, 186, 1.0); // #bababa
  static final Color avLightGreyColor = Color.fromRGBO(234, 234, 234, 1.0); // #eaeaea
  static final Color avLightestGreyColor = Color.fromRGBO(250, 250, 250, 1.0); // #fafafa

  static final double appBarFontSize = 18.0;

  static final ThemeData mainTheme = ThemeData(
    primarySwatch: avPrimaryColor,
    accentColor: avPinkColor,
    dividerColor: avGreyColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: avDarkColor),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
              fontFamily: globals.defaultFontName,
              fontSize: appBarFontSize,
            ),
          ),
    ),
    fontFamily: globals.defaultFontName,
    textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: avDarkColor),
          headline2: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: avDarkColor),
          headline3: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: avLightColor),
          headline4: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: avLightColor),
          headline5: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: avDarkColor),
          bodyText1: TextStyle(fontSize: 12, color: avDarkColor),
          bodyText2: TextStyle(fontSize: 12, color: avPinkColor),
          subtitle1: TextStyle(fontSize: 12, color: avDarkColor, fontWeight: FontWeight.w200),
          subtitle2: TextStyle(fontSize: 12, color: avGreyColor, fontWeight: FontWeight.w200),
          caption: TextStyle(fontSize: 9, color: avDarkColor, fontWeight: FontWeight.bold),
        ),
  );
}
