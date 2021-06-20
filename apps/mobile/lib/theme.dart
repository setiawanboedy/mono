import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  Color black = const Color(0xFF000000);
  Color white = const Color(0xFFFFFFFF);

  Color darkBackground = const Color(0xFF222222);

  Color openGreen = const Color(0xFF4CAF50);
  Color closedRed = const Color(0xFFF44336);
  Color unknownGrey = const Color(0xFF9E9E9E);

  Color disabledGrey = const Color(0xFF757575);
  Color cardGrey = const Color(0xFFEEEEEE);

  TextTheme textTheme(Brightness brightness) {
    const TextTheme base = TextTheme();

    final bool isDark = brightness == Brightness.dark;

    final TextStyle titleTextTheme = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mulish',
      color: white,
    );

    final TextStyle subtitleTextTheme = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mulish',
      color: white,
    );

    final TextStyle bodyTextTheme = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Mulish',
      color: isDark ? white : black,
    );

    return base.copyWith(
      headline1: titleTextTheme,
      headline2: titleTextTheme,
      headline3: titleTextTheme,
      headline4: titleTextTheme,
      headline5: titleTextTheme,
      headline6: titleTextTheme,
      subtitle1: subtitleTextTheme,
      subtitle2: subtitleTextTheme,
      bodyText1: bodyTextTheme,
      bodyText2: bodyTextTheme,
      caption: bodyTextTheme,
      button: bodyTextTheme,
      overline: bodyTextTheme,
    );
  }

  ThemeData buildBaseTheme() {
    final ThemeData base = ThemeData(fontFamily: 'Mulish');

    return base;
  }

  ThemeData dark() {
    final ThemeData base = buildBaseTheme();

    return base.copyWith(
      brightness: Brightness.dark,
      primaryColor: black,
      scaffoldBackgroundColor: darkBackground,
      backgroundColor: darkBackground,
      buttonColor: white,
      textTheme: textTheme(Brightness.dark),
    );
  }

  ThemeData light() {
    final ThemeData base = buildBaseTheme();

    return base.copyWith(
      brightness: Brightness.light,
      primaryColor: black,
      scaffoldBackgroundColor: white,
      backgroundColor: white,
      buttonColor: black,
      textTheme: textTheme(Brightness.light),
    );
  }
}
