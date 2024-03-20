import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_brain/src/theme/app_theme.dart';
import 'package:second_brain/src/utils/app_exports.dart';

import 'init_page_ctrl.dart';

class InitPage extends StatelessWidget {
  final InitPageCtrl c = Get.put(InitPageCtrl());

  InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            DropdownButton<ThemeEnum>(
              items: ThemeEnum.values
                  .map((e) => DropdownMenuItem<ThemeEnum>(child: Text(e.name)))
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                switch (v) {
                  case ThemeEnum.defaultTheme:
                    if (c.isDarkMode.isTrue) {
                      Get.changeTheme(AppTheme.defaultLightTheme);
                    } else {
                      Get.changeTheme(AppTheme.defaultDarkTheme);
                    }
                    break;
                  case ThemeEnum.redTheme:
                    if (c.isDarkMode.isTrue) {
                      Get.changeTheme(AppTheme.redLightTheme);
                    } else {
                      Get.changeTheme(AppTheme.redDarkTheme);
                    }
                    break;
                }
                c.theme(v);
              },
            ),
            CupertinoSwitch(
              value: c.isDarkMode.value,
              onChanged: (value) {
                if (value) {
                  switch(c.theme()){

                    case ThemeEnum.defaultTheme:
                    case ThemeEnum.redTheme:
                      // TODO: Handle this case.
                  }
                }else{
                  switch(c.theme()){

                    case ThemeEnum.defaultTheme:
                    // TODO: Handle this case.
                    case ThemeEnum.redTheme:
                    // TODO: Handle this case.
                  }
                }
              },
            )

            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: context.theme.colorScheme.primary,
            //     foregroundColor: context.theme.scaffoldBackgroundColor,
            //   ),
            //   onPressed: () {
            //     if (c.isDarkMode.isTrue) {
            //       c.isDarkMode(false);
            //       logger.d("Light Mode Set");
            //       Get.changeThemeMode(ThemeMode.light);
            //     } else {
            //       c.isDarkMode(true);
            //       logger.d("Dark Mode Set");
            //       Get.changeThemeMode(ThemeMode.dark);
            //     }
            //     logger.d("Current Mode is Dark Mode:${context.isDarkMode}");
            //   },
            //   child: const Text("Change Theme"),
            // ),
          ],
        ),
      ),
    );
  }
}
