import 'package:captable/src/backend/Employee/employee_api.dart';
import 'package:captable/src/backend/auth/auth_api.dart';
import 'package:captable/src/modules/auth/login/login_page.dart';
import 'package:captable/src/modules/auth/signup/startup_detail/company_detail_page_ctrl.dart';
import 'package:captable/src/modules/home/home_page.dart';
import 'package:captable/src/utils/app_exports.dart';

import '../auth/forgot_password/forgot_password_page.dart';
import '../auth/signup/add_captable/add_captable_page.dart';
import '../auth/signup/startup_detail/company_detail_page.dart';

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

    Get.offAll(() =>  AddCaptablePage());

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
