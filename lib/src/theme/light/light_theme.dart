import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:second_brain/src/utils/constant/app_colors.dart';

class LightTheme{
  static const fonts = 'lato';

  static final theme = ThemeData(
    fontFamily: fonts,
    useMaterial3: false,
    iconTheme: const IconThemeData(color: Colors.black),
    primarySwatch: Colors.grey,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontFamily: fonts,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          fontSize: 15,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        minimumSize: const Size(95, 30),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(
          color: Get.theme.scaffoldBackgroundColor,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: fonts,
        fontSize: 40,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: fonts,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontFamily: fonts,
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontFamily: fonts,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        fontFamily: fonts,
        letterSpacing: 0.7,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    ),
  );
}