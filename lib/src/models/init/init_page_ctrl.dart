import 'package:get/get.dart';
import 'package:second_brain/src/theme/app_theme.dart';

class InitPageCtrl extends GetxController {
  Rx<ThemeEnum> theme = ThemeEnum.defaultTheme.obs;
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    authCheck();
    super.onInit();
  }

  Future<void> authCheck() async {
    await 2.delay();
  }
}
