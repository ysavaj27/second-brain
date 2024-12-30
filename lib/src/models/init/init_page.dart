import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

          ],
        ),
      ),
    );
  }
}
