import 'package:second_brain/src/utils/app_exports.dart';

enum AuctionStatusType {
  ended(status: -1, color: AppColors.primary),
  ideal(status: 0, color: Colors.white),
  current(status: 1, color: Colors.green),
  upcoming(status: 2, color: Colors.yellow);

  const AuctionStatusType({this.status = 0, this.color = Colors.white});

  final int status;
  final Color color;
}

enum ThemeEnum { defaultTheme, redTheme }

enum IndustryEnum { technology, finance }

enum ShareTypeEnum { None, Equity, CCPS, CCD, Eshop, Male }

enum PersonTypeEnum { None, Founder, Investor, Employee, VC, Angel }

enum GenderTypeEnum { Male, Female }

enum SignUpEnum { company, location, additional }

enum ForgotPassEnum { mobile, otp, password }

enum TabBarEnum { dashboard, mis, financial, employee, captable, profile }

enum ActionEnum { share, edit, delete }

enum MessageEnum { info, success, error, alert }

enum GradientEnum { auth, app, none }

enum FileDataType { url, filePath, bytes, none }

enum FileShareType { email, whatsapp }
