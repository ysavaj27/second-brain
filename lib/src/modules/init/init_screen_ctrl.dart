import 'package:second_brain/src/utils/app_exports.dart';

class InitScreenCtrl extends GetxController {
  Future<void> loginCheck() async {
    logger.d("User Login :${app.isUserLogin} Is Register :${app.user.startup.status}");
    // if (app.isUserLogin) {
    //   if (app.isRegister) {
    //     Get.offAll(() => HomePage());
    //   } else {
    //     Get.offAll(() => CompanyDetailPage());
    //   }
    // } else {
    //   Get.offAll(() => LoginPage());
    // }


    // Get.offAll(() => AddCaptablePage());
    // Get.offAll(() =>  ForgotPasswordPage());
    // Get.offAll(() => HomePage());
  }

  @override
  void onInit() {
    setData();
    super.onInit();
  }

  Future<void> setData() async {
    await init.initConfig();
    await 2.delay();
    await masterConfig.getAll();
    loginCheck();
  }
}
