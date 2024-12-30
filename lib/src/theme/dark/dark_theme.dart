import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkTheme {
  static const fonts = 'lato';

  static final theme = ThemeData(
    fontFamily: fonts,
    iconTheme: const IconThemeData(color: Colors.white),
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontFamily: fonts),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: fonts,
        fontSize: 40,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
          fontFamily: fonts, fontSize: 20, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(
        fontFamily: fonts,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      labelMedium: TextStyle(
        fontFamily: fonts,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      labelSmall: TextStyle(
        fontFamily: fonts,
        letterSpacing: 0.7,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
