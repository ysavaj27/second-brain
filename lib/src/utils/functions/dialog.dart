import 'package:second_brain/src/utils/app_exports.dart';

Future<Object?> showCustomDialog(Widget widget, [barrierDismissible = true]) async {
 return await showGeneralDialog(
    context: Get.context!,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: widget,
      );
    },
  );
}
