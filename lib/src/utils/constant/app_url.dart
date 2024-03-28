import '../app_exports.dart';

class AppUrl {
  static const String baseURL = "http://65.2.148.207/api/v1/";
  static String imageURL = masterConfig.config.s3Baseurl;

  // static const String imageURL =
  //     "https://shuruup-captable.s3.ap-south-1.amazonaws.com/";

  /// AUTH
  static const String login = "login";
  static const String logout = "logout";
  static const String forgotVerifyUser = "forgot/verify-user";
  static const String forgotVerifyCode = "forgot/verify-code";
  static const String forgotResetPassword = "forgot/reset-password";

  /// EMPLOYEE
  static const String employeeGet = "employee";
  static const String employeeCreate = "employee/create";
  static const String employeeDelete = "employee/delete";
  static const String employeeUpdate = "employee/update";

  /// EMPLOYEE
  static const String roundGet = "master/round";
  static const String roundCreate = "master/round/create";
  static const String roundDelete = "master/round/delete";
  static const String roundUpdate = "master/round/update";

  static const String misListGet = "mis";
  static const String misCreate = "mis/create";
  static const String misUpdate = "mis/update";
  static const String misDelete = "mis/delete";
  static const String misSend = "mis/send";

  static const String financialDocumentListGet = "financial-document";
  static const String financialDocumentCreate = "financial-document/create";
  static const String financialDocumentUpdate = "financial-document/update";
  static const String financialDocumentDelete = "financial-document/delete";
  static const String financialDocumentSend = "financial-document/send";

  static const String sectorGet = "master/sector";
  static const String sectorAdd = "master/sector/create";
  static const String instrumentTypeGet = "master/instrument-type";
  static const String investorTypeGet = "master/investortype";
  static const String countryGet = "master/country";
  static const String stateGet = "master/state";
  static const String cityGet = "master/city";
  static const String roundType = "master/roundtype";

  static const String startupUpdate = "startup/update";
  static const String startupView = "startup";

  static const String config = "get-config";
}
