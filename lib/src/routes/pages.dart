
import 'package:second_brain/src/modules/init/init_screen.dart';

import '../utils/app_exports.dart';


class Pages {
  static const Transition downUp = Transition.downToUp;
  static const Transition rightLeft = Transition.rightToLeft;
  static const Transition leftRight = Transition.leftToRight;
  static const Transition cupertino = Transition.cupertino;

  static List<GetPage> pages = [
    GetPage(name: Routes.init, page: () => InitScreen(), transition: downUp),
    // GetPage(name: Routes.signIn, page: () => SignIn(), transition: downUp),
    // GetPage(name: Routes.signUp, page: () => const Signup(), transition: downUp),
    // GetPage(name: Routes.home, page: () => HomePage(), transition: downUp),
    // GetPage(name: Routes.profile, page: () => const Profile(), transition: leftRight),
  ];
}
