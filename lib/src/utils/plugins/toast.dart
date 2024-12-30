import 'package:second_brain/src/utils/app_exports.dart';
// void showToast(String message) {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

void toast(String message, [MessageEnum type = MessageEnum.info]) {
  Color backgroundColor() {
    switch (type) {
      case MessageEnum.info:
        return AppColors.primary;
      case MessageEnum.success:
        return Colors.green.shade400;
      case MessageEnum.error:
        return Colors.red.shade400;
      case MessageEnum.alert:
        return Colors.orange.shade400;
    }
  }

  Get.showSnackbar(
    GetSnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      duration: const Duration(milliseconds: 2000),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      maxWidth: 650,
      borderRadius: 10,
      margin: const EdgeInsets.only(top: 15),
      animationDuration: const Duration(milliseconds: 600),
      dismissDirection: DismissDirection.endToStart,
      // forwardAnimationCurve: Curves.easeInOut,
      // reverseAnimationCurve: Curves.easeOut,
      // message: message,
      // title: ,
      // titleText: Text(
      //   isSuccess ? "Success" : "Failed",
      //   style: const TextStyle(
      //       fontWeight: FontWeight.w600, fontSize: 17, color: Colors.black),
      // ),
      messageText: Text(
        message,
        style:
            TextStyle(color: Get.theme.scaffoldBackgroundColor, fontSize: 14),
      ),
      backgroundColor: backgroundColor(),
    ),
  );
}
