
import 'package:second_brain/src/utils/app_exports.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsets? padding;

  const CustomTextButton(
      {super.key, required this.text,required this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: padding),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.primary),
      ),
    );
  }
}
