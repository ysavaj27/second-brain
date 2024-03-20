import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_brain/src/models/init/init_page.dart';
import 'package:second_brain/src/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultLightTheme,
      darkTheme: AppTheme.defaultDarkTheme,
      themeMode: ThemeMode.light,
      home: InitPage(),
    );
  }
}
