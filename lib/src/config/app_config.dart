import '../utils/app_exports.dart';

final AppConfig app = AppConfig.instance;

class AppConfig extends GetxService {
  static final AppConfig instance = AppConfig();

  Rx<UserModel> userModel = UserModel.fromJson({}).obs;

  UserModel get user => userModel();

  bool get isRegister => user.startup.status == 1;

  bool get isUserLogin =>
      userModel().token.isNotEmpty && userModel().email.isNotEmpty;

  Future<void> getUser() async {
    var s =await prefs.getValue(key: AppKey.userKey);
    if (s != null && s is Map<String, dynamic>) {
      logger.f(s);
      userModel(UserModel.fromJson(s));
      if (isUserLogin) {
        // getUserFromDB(user: user());
      }
    }
    return;
  }

  // Future<void> getUserFromDB({required UserModel user}) async {
  //   try {
  //     dio.init(user);
  //     var response =
  //         await dio.get(url: '${UrlConst.getUser}/${user.email}', params: {});
  //     // logger.wtf(response.toJson());
  //     if (response.status == 200) {
  //       UserModel prefUser = UserModel(
  //           email: response.userName,
  //           fName: response.fName,
  //           lName: response.lName,
  //           token: user.token);
  //       setUser(prefUser: prefUser);
  //     } else if (response.status == 404) {
  //       return;
  //     } else {
  //       logger.e(response.message);
  //       return;
  //     }
  //   } catch (e, t) {
  //     logger.e('$e\n$t');
  //     return;
  //   }
  // }

  Future<void> setUser({required UserModel prefUser}) async {
    try {
      userModel(prefUser);
      logger.i(prefUser.toJson());
      await prefs.setValue(key: AppKey.userKey, value: prefUser.toJson());
    } catch (e, t) {
      logger.e('$e\n$t');
    }
  }

// Future<void> atOtp({required String email}) async {
//   try {
//     await prefs.setValue(key: KeyConst.otpKey, value: email);
//   } catch (e, t) {
//     logger.e('$e\n$t');
//   }
// }
}
